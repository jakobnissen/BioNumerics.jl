"""
BioNumerics

The `BioNumerics` package provides functions to interface with SSI's BioNumerics
databases. It can be used to automatically read from or write to, BioNumerics
databases, and thus automate some of the database management.
"""
module BioNumerics

using UUIDs
using Dates
using ODBC
using CSV
using DBInterface
using DataFrames # TODO: Is this necessary?

const DATETIME_FORMAT = dateformat"dd/mm/yyyy HH.MM"
const DATE_FORMAT = dateformat"dd/mm/yyyy"

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

include("hosts.jl")
using .Hosts

struct VNumber
    x::UInt32
end

function VNumber(s::Union{String, SubString{String}})
    if ncodeunits(s) != 10 || codeunit(s, 1) != UInt8('V')
        error("Invalid VNumber: \"", s, '"')
    end
    VNumber(parse(UInt32, view(s, 2:10)))
end 

Base.show(io::IO, v::VNumber) = print(io, 'V', lpad(v.x, 9, '0'))

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
    print(io, "SAG-", x.numbers, '-', uppercase(string(x.letters, base=36)))
end

# Dummy object
struct Material end

struct LIMSRow
    id::UInt128
    modified::DateTime
    samplenum::NTuple{2, UInt16}
    vnum::VNumber
    sag::SagsNumber
    material::Union{Nothing, Material}
    created::DateTime
    host::Host
    receivedate::DateTime
    sampledate::Union{Nothing, Date}
end

function parse_samplenum(s::AbstractFloat)
    fraction, integer = modf(s)
    while !iszero(modf(round(fraction, digits=8))[1])
        fraction *= 10
    end
    return UInt16(integer), UInt16(fraction)
end

function parse_lims(io::IO)
    csv = CSV.File(io)
    if propertynames(csv) != COLUMNS
        error("Found wrong columns, expected $COLUMNS")
    end
    nothing
end

macro ornothing(expr)
    quote
        local res = $(esc(expr))
        ismissing(res) && return nothing
        res
    end
end

function tryparse_lims(row::CSV.Row)::Union{Nothing, LIMSRow}
    id = parse_limsid(row[1])
    # we skip the hash at col 2, we don't need to store it
    modified = DateTime(row[3], DATETIME_FORMAT)
    samplenum = parse_samplenum(row[4])
    vnum = VNumber(@ornothing(row[5]))
    sag = SagsNumber(@ornothing(row[6]))
    material = if ismissing(row[7]) # TODO
        nothing
    else
        Material()
    end
    created = DateTime(row[8], DATETIME_FORMAT)
    host = if ismissing(row[9])
        nothing
    else
        Hosts.unknown_duck ## TODO
    end
    receivedate = DateTime(row[10], DATETIME_FORMAT)
    sampledate = if ismissing(row[11])
        nothing
    else
        Date(row[11], DATE_FORMAT)
    end
    LIMSRow(
        id,
        modified,
        samplenum,
        vnum,
        sag,
        material,
        created,
        host,
        receivedate,
        sampledate
    )
end

# It's in UUID format, but it somehow has values not permitted in proper
# UUID. So I leverage the UUID parser, but return an UInt128
parse_limsid(s::Union{String, SubString{String}}) = UInt128(UUID(s))




module Viruses
@enum Virus::UInt8 Negative InfA InfB
export Virus
end
using .Viruses

#=
function establish_connection(server::AbstractString, database::AbstractString)
    Sys.isapple() && ODBC.setunixODBC()
    if !haskey(ODBC.drivers(), "ms")
        error("Must have driver \"ms\"")
    end
    return DBInterface.connect(
        ODBC.Connection,
        "DRIVER={ms};
        SERVER=$(server);
        Trusted_Connection=Yes;
        DATABASE=$(database);"
    )
end
##
connection = establish_connection("srv-mssql-07p.ssi.ad", "BN_AIV")

dataframe = DBInterface.execute(
    connection,
    "SELECT * FROM ENTRYTABLE WHERE SeqRun = 'NGS#90'"
) |> DataFrame
=#

end # module

# Vnum
# Mod date
# Sag
# Prøvenummer
# Dyreart
# Virusart               <------
# H subtype              <------
# N subtype              <------
# Patogenecitet          <------
# Cleavage site          <------
# Sample date
# SSI date
# Sample material
# NGS
# Sequences themselves   <------