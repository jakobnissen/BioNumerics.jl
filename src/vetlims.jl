const DATETIME_FORMAT = dateformat"dd/mm/yyyy HH.MM"
const DATE_FORMAT = dateformat"dd/mm/yyyy"

"Columns from CSV file exported from VetLIMS, in order"
const COLUMNS = [
    Symbol("(Skal ikke ændres) Prøve"),
    Symbol("(Skal ikke ændres) Kontrolsum for række"),
    Symbol("(Skal ikke ændres) Ændret"),
    Symbol("Prøve id"),
    Symbol("Internt nr."),
    Symbol("Sags ID"),
    :Materiale,
    :Oprettet,
    :Dyreart,
    :Modtagelsestidspunkt,
    :Udtagelsesdato
]

struct SampleNumber
    num::UInt16
    subnum::UInt16
end

SampleNumber(x::Integer) = SampleNumber(UInt16(x), 0)

function SampleNumber(x::AbstractFloat)
    fraction, integer = modf(x)
    fraction = round(fraction, digits=8)
    while !iszero(modf(fraction)[1])
        fraction *= 10
        fraction = round(fraction, digits=8)
    end
    return SampleNumber(UInt16(integer), UInt16(fraction))
end

function Base.show(io::IO, x::SampleNumber)
    print(io, summary(x), '(', x.num, ", ", x.subnum, ')')
end

struct VNumber
    x::UInt32
end

function VNumber(s::Union{String, SubString{String}})
    if ncodeunits(s) != 10 || codeunit(s, 1) != UInt8('V')
        error("Invalid VNumber: \"", s, '"')
    end
    VNumber(parse(UInt32, view(s, 2:10)))
end 

Base.show(io::IO, v::VNumber) = print(io, summary(v), "(\"V", string(v.x, pad=9), "\")")

struct SagsNumber
    numbers::UInt32
    letters::UInt32
end

function SagsNumber(s::Union{String, SubString{String}})
    if ncodeunits(s) != 16 || !startswith(s, "SAG-") || codeunit(s, 10) != UInt8('-')
        error("Invalid SagsNumber: \"", s, '"')
    end
    numbers = parse(UInt32, view(s, 5:9))
    letters = parse(UInt32, view(s, 11:16), base=36)
    SagsNumber(numbers, letters)
end

function Base.show(io::IO, x::SagsNumber)
    letters = uppercase(string(x.letters, base=36, pad=6))
    print(io, summary(x), "(\"SAG-", string(x.numbers, pad=5), '-', letters, "\")")
end

struct LIMSRow
    samplenum::SampleNumber
    vnum::VNumber
    sag::SagsNumber
    sampledate::Union{Nothing, Date}
    host::Host
    material::Union{Nothing, Material}
    receivedate::DateTime
end

function parse_lims(io::IO)
    csv = CSV.File(io)
    if propertynames(csv) != COLUMNS
        error("Found wrong columns, expected $COLUMNS")
    end
    return map(LIMSRow, csv)
end

function LIMSRow(row::CSV.Row)
    # We skip rows 1, 2 and 3, which are internal fields. They are, respectively:
    # 128-bit UUID, checksum, datetime modified
    samplenum = SampleNumber(row[4])
    vnum = VNumber(row[5])
    sag = SagsNumber(row[6])
    material = let
        v = row[7]
        ismissing(v) ? nothing : parse(Material, v)
    end
    # Skip row 8: Created datetime
    host = let
        v = row[9]
        ismissing(v) ? nothing : parse(Host, v)
    end
    receivedate = DateTime(row[10], DATETIME_FORMAT)
    sampledate = let
        v = row[11]
        ismissing(v) ? nothing : Date(v, DATE_FORMAT)
    end
    LIMSRow(
        samplenum,
        vnum,
        sag,
        sampledate,
        host,
        material,
        receivedate,
    )
end