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
    :Oprettet, ############# delete, remember to update row parser with new col indices
    :Dyreart,
    :Modtagelsestidspunkt,
    :Udtagelsesdato
]

struct SampleNumber
    num::UInt16
    subnum::UInt16
end

SampleNumber(x::Integer) = SampleNumber(UInt16(x), 0)

function parse_dot(::Type{SampleNumber}, s::Union{String, SubString{String}})
    str = strip(s)
    p = findfirst(isequal(UInt8('.')), codeunits(str))
    return if p === nothing
        SampleNumber(parse(UInt16, str), 0)
    else
        SampleNumber(
            parse(UInt16, str[1:prevind(str, p)]),
            parse(UInt16, str[p+1:end])
        )
    end
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

Base.print(io::IO, v::VNumber) = print(io, 'V' * string(v.x, pad=9))
Base.show(io::IO, v::VNumber) = print(io, summary(v), "(\"", string(v), "\")")

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

function Base.print(io::IO, x::SagsNumber)
    print(io, "SAG-" * string(x.numbers, pad=5) * '-' * uppercase(string(x.letters, base=36, pad=6)))
end
Base.show(io::IO, x::SagsNumber) = print(io, summary(x), "(\"", string(x), "\")")

struct LIMSRow
    samplenum::SampleNumber
    vnum::VNumber
    sag::SagsNumber
    sampledate::Union{Nothing, Date}
    material::Union{Nothing, Material}
    host::Host
    receivedate::DateTime
end

function parse_lims(io::IO)
    csv = CSV.File(io,
        decimal=',',
        delim=';',
        strict=true,
        dateformats=Dict(
            3  => DATETIME_FORMAT,
            8  => DATETIME_FORMAT,
            10 => DATETIME_FORMAT,
            11 => DATE_FORMAT,
        )
    )
    if propertynames(csv) != COLUMNS
        error("Found wrong columns, expected $COLUMNS")
    end
    return map(LIMSRow, csv)
end

function LIMSRow(row::CSV.Row)
    # We skip rows 1, 2 and 3, which are internal fields. They are, respectively:
    # 128-bit UUID, checksum, datetime modified
    samplenum = parse_dot(SampleNumber, row[4])
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
    receivedate = row[10]
    sampledate = let
        v = row[11]
        ismissing(v) ? nothing : v
    end
    LIMSRow(
        samplenum,
        vnum,
        sag,
        sampledate,
        material,
        host,
        receivedate,
    )
end