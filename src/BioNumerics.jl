"""
BioNumerics

The `BioNumerics` package provides functions to interface with SSI's BioNumerics
databases. It can be used to automatically read from or write to, BioNumerics
databases, and thus automate some of the database management.
"""
module BioNumerics

using Dates
using CSV
#using ODBC
#using DBInterface
#using DataFrames # TODO: Is this necessary?


include("hosts.jl")
using .Hosts

include("vetlims.jl")

#=
module Viruses
@enum Virus::UInt8 Negative InfA InfB
export Virus
end
using .Viruses

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