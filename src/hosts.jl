module Hosts

import ..english, ..danish, ..dedup_categories

const _HOSTS = Tuple{String, Union{String, Nothing}}[
    ("Abe", "Monkey"),
    ("Agerhøne", "Grey partridge"),
    ("Agerhøne i opdræt", "Captive-reared grey partridge"),
    ("Allike", "Western jackdaw"),
    ("Almindelig ryle", "Dunlin"),
    ("Almindeligt marsvin", "Harbour porpoise"),
    ("Alpaca", "Alpaca"),
    ("And", "Duck"),
    ("Andefugl", "Duck"),
    ("Antilope", "Antelope"),
    ("Australsk ravfisk", nothing),
    ("Balistær", "Bali myna"),
    ("Bison", "Bison"),
    ("Biæder", "Bee-eater"),
    ("Bjerglori", "Coconut lorikeet"),
    ("Blisgås", "Greater white-fronted goose"),
    ("Blishøne", "Eurasian coot"),
    ("Blå kærhøg", "Hen harrier"),
    ("Blåmejse", "Eurasian blue tit"),
    ("Blåræv", "Blue fox"),
    ("Bogfinke", "Common chaffinch"),
    ("Bourkes parakit", "Bourke's parrot"),
    ("Bovidae", nothing),
    ("Bramgås", "Barnacle goose"),
    ("Brevdue", "Homing pigeon"),
    ("Brud", "Least weasel"),
    ("Brunflagermus", "Common noctule"),
    ("BSL3", "BSL3"),
    ("Bæver", "Eurasian beaver"),
    ("Chimpanse", "Chimpanzee"),
    ("Chinchilla", "Chinchilla"),
    ("Delfin", "Dolphin"),
    ("Dobbeltbekkasin", "Common snipe"),
    ("Dovendyr", "Sloth"),
    ("Dromedar", "Dromedary"),
    ("Drossel", "True thrush"),
    ("Due", "Pigeon"),
    ("Duehøg", "Northern goshawk"),
    ("Dværgfalk", "Merlin"),
    ("Dværgflodhest", "Pygmy hippopotamus"),
    ("Dværgged", "Pygmy goat"),
    ("Dværghøne", "Bantam chicken"),
    ("Dværgpapegøje", "Lovebird"),
    ("Dådyr", "Fallow deer"),
    ("Ederfugl", "Common eider"),
    ("Egern", "Squirrel"),
    ("Elefant", "Elephant"),
    ("Elg", "Elk"),
    ("Falk", "Falcon"),
    ("Fasan", "Common pheasant"),
    ("Fasan i opdræt", "Captive-reared pheasant"),
    ("Fasandue", "Pheasant pigeon"),
    ("Finke", "Finch"),
    ("Fisk", "Fish"),
    ("Fiskehejre", "Grey heron"),
    ("Fiskeørn", "Western osprey"),
    ("Fjeldvåge", "Rough-legged buzzard"),
    ("FJERKRÆTEST", nothing),
    ("Flagermus", "Bat"),
    ("Flamingo", "Flamingo"),
    ("Fløjlsand", "Velvet scoter"),
    ("Fritte", "Ferret"),
    ("Fugl", "Bird"),
    ("Fuglekonge", "Goldcrest"),
    ("Får", "Sheep"),
    ("Ged", "Goat"),
    ("Giraf", "Giraffe"),
    ("Gnu", "Wildebeest"),
    ("Gotlandsk får", "Gotland sheep"),
    ("Gravand", "Common shelduck"),
    ("Grævling", "European badger"),
    ("Grønbenet rørhøne", "Common moorhen"),
    ("Grønirisk", "European greenfinch"),
    ("Grå jaco", "Grey parrot"),
    ("Gråand", "Mallard"),
    ("Grågås", "Greylag goose"),
    ("Gråkrage", "Hooded crow"),
    ("Gråstrubet lappedykker", "Red-necked grebe"),
    ("Gråsæl", "Grey seal"),
    ("Guanaco", "Guanaco"),
    ("Gulnæbbet toko", "Eastern yellow-billed hornbill"),
    ("Gulspurv", "Yellowhammer"),
    ("Gås", "Goose"),
    ("Hamsterfamilien", "Cricetid"),
    ("Hare", "European hare"),
    ("Havørn", "White-tailed eagle"),
    ("Hedehøg", "Montagu's harrier"),
    ("Hest", "Horse"),
    ("Hjejle", "European golden plover"),
    ("Hjorteantilope", "Blackbuck"),
    ("Hjortefamilien", "Deer"),
    ("Hund", "Dog"),
    ("Husmus", "House mouse"),
    ("Husmår", "Beech marten"),
    ("Husskade", "Eurasian magpie"),
    ("Hvepsevåge", "European honey buzzard"),
    ("Hvidnæse", "White-beaked dolphin"),
    ("Hængebugsvin", "Vietnamese pot-bellied pig"),
    ("Hærfugl", "Eurasian hoopoe"),
    ("Hættemåge", "Black-headed gull"),
    ("Høg", "Hawk"),
    ("Høns", "Chickens"),
    ("Hønsefugle", "Galliforms"),
    ("Ibis", "Ibis"),
    ("Ilder", "European polecat"),
    ("Impala", "Impala"),
    ("Isbjørn", "Polar bear"),
    ("Islandsk ryle", "Red knot"),
    ("Jernspurv", "Dunnock"),
    ("Kakadue", "Cockatoo"),
    ("Kalkun", "Turkey"),
    ("Kamel", "Camel"),
    ("Kamelfamilien", "Camelid"),
    ("Kanariefugl", "Atlantic canary"),
    ("Kanin", "Rabbit"),
    ("Kaspisk måge", "Caspian gull"),
    ("Kat", "Cat"),
    ("Kattalemur", "Ring-tailed lemur"),
    ("Knarand", "Gadwall"),
    ("Knopsvane", "Mute swan"),
    ("Knortegås", "Brent goose"),
    ("Kongepingvin", "King penguin"),
    ("Kongeørn", "Golden eagle"),
    ("Korthovedet flyvepungegern", "Sugar glider"),
    ("Kortnæbbet gås", "Pink-footed goose"),
    ("Krage", "Crow"),
    ("Kragefugl", "Corvid"),
    ("Krikand", "Eurasian teal"),
    ("Krokodille", "Crocodile"),
    ("Krondue", "Crowned pigeon"),
    ("Krondyr", "Red deer"),
    ("Kvæg", "Cattle"),
    ("Kylling", "Chicken"),
    ("Kænguru", "Kangaroo"),
    ("Lama", "Llama"),
    ("Lappedykker", "Grebe"),
    ("Leopard", "Leopard"),
    ("Lille flagspætte", "Little plaice"),
    ("Lille lappedykker", "Little grebe"),
    ("Lille regnspove", "Eurasian whimbrel"),
    ("Lomvie", "Common murre"),
    ("Lækat", "Stoat"),
    ("Løvsanger", "Willow warbler"),
    ("Marsvinefamilien", "Porpoise"),
    ("Minigris", "Miniature pig"),
    ("Mink", "Mink"),
    ("Mixed", "Mixed"),
    ("Mosehornugle", "Short-eared owl"),
    ("Moskusand", "Muscovy duck"),
    ("Moskusokse", "Muskox"),
    ("Muflon", "Mouflon"),
    ("Muldvarp", "European mole"),
    ("Muldyr", "Mule"),
    ("Mus", "Mouse"),
    ("Musvåge", "Common buzzard"),
    ("Måge", "Gull"),
    ("Mårfamilien", "Mustelid"),
    ("Mårhund", "Raccoon dog"),
    ("Nandu", "Greater rhea"),
    ("Natugle", "Tawny owl"),
    ("Nilgås", "Egyptian goose"),
    ("Nymfeparakit", "Cockatiel"),
    ("Næbhval", "Sowerby's beaked whale"),
    ("Odder", "Eurasian otter"),
    ("Okapi", "Okapi"),
    ("Orangutang", "Orangutan"),
    ("Papegøje", "Parrot"),
    ("Papegøjefamilien", nothing),
    ("Parakit", "Parakeet"),
    ("Pelikan", "Pelican"),
    ("Perlehøne", "Helmeted guineafowl"),
    ("Pibeand", "Eurasian wigeon"),
    ("Pindsvin", "European hedgehog"),
    ("Pingvin", "Penguin"),
    ("Påfugl", "Indian peafowl"),
    ("Ravn", "Common raven"),
    ("Rensdyr", "Reindeer"),
    ("Ringdue", "Common wood pigeon"),
    ("Rotte", "Rat"),
    ("Rovdyr", "Predator"),
    ("Rovfugl", "Bird of prey"),
    ("Ræv", "Fox"),
    ("Rød glente", "Red kite"),
    ("Rødben", "Common redshank"),
    ("Rørdrum", "Eurasian bittern"),
    ("Rådyr", "Roe deer"),
    ("Råge", "Rook"),
    ("Sangdrossel", "Song thrush"),
    ("Sangsvane", "Whooper swan"),
    ("Sejhval", "Sei whale"),
    ("Sika", "Sika deer"),
    ("Sildemåge", "Lesser black-backed gull"),
    ("Sjagger", "Fieldfare"),
    ("Skarv", "Great cormorant"),
    ("Skeand", "Northern shoveler"),
    ("Skoggerdue", "African collared dove"),
    ("Skovdue", nothing),
    ("Skovhornugle", "Long-eared owl"),
    ("Skovmår", "European pine marten"),
    ("Skovskade", "Eurasian jay"),
    ("Skovsneppe", "Eurasian woodcock"),
    ("Slagtekylling", "Broiler chicken"),
    ("Slørugle", "Barn owl"),
    ("Småspove", "Eurasian whimbrel"),
    ("Sneppe", "Sandpiper"),
    ("Sneugle", "Snowy owl"),
    ("Solsort", "Common blackbird"),
    ("Sortand", "Common scoter"),
    ("Sortkrage", "Carrion crow"),
    ("Spidsand", "Northern pintail"),
    ("Spurvehøg", "Eurasian sparrowhawk"),
    ("Spurvepapegøje", "Parrotlet"),
    ("Spættet sæl", "Harbor seal"),
    ("Stor flagspætte", "Big woodpecker"),
    ("Stor hornugle", "Eurasian eagle-owl"),
    ("Stor præstekrave", "Common ringed plover"),
    ("Stor skallesluger", "Common merganser"),
    ("Stork", "Stork"),
    ("Stormmåge", "Common gull"),
    ("Storspove", "Eurasian curlew"),
    ("Strandhjejle", "Grey plover"),
    ("Struds", "Common ostrich"),
    ("Stuefugl", "Cage bird"),
    ("Stær", "Common starling"),
    ("Sule", "Northern gannet"),
    ("Svane", "Swan"),
    ("Svartbag", "Great black-backed gull"),
    ("Svin", "Pig"),
    ("Sædgås", "Taiga bean goose"),
    ("Sæl", "Seal"),
    ("Sølvmåge", "European herring gull"),
    ("Tapir", "Tapir"),
    ("Tejst", "Black guillemot"),
    ("TEST-API-DYR", "TEST-API-Animal"),
    ("TEST-API-DYR2", "TEST-API-Animal2"),
    ("Toppet lappedykker", "Great crested grebe"),
    ("Torsk", "Codfish"),
    ("Troldand", "Tufted duck"),
    ("Tyknæbbet lappedykker", "Pied-billed grebe"),
    ("Tyr", "Bull"),
    ("Tårnfalk", "Common kestrel"),
    ("Ugle", "Owl"),
    ("Ukendt", "Unknown"),
    ("Ulv", "Wolf"),
    ("Undulat", "Budgerigar"),
    ("Vagtel", "Quail"),
    ("Vandflagermus", "Daubenton's bat"),
    ("Vandrefalk", "Peregrine falcon"),
    ("Vandrikse", "Water rail"),
    ("Vaskebjørn", "Raccoon"),
    ("Vibe", "Northern lapwing"),
    ("Vild kanin", "European rabbit"),
    ("Vildsvin", "Wild boar"),
    ("Vædder", "Ram"),
    ("Vågehval", "Common minke whale"),
    ("Zebra", "Zebra"),
    ("Zoofugl", "Zoo-bird"),
    ("Ælling", "Duckling"),
    ("Ænder", "Ducks"),
    ("Æsel", "Donkey"),
    ("Ørn", "Eagle"),
]  |> dedup_categories

expr = :(@enum Host::UInt16)
for (sym, da, en) in _HOSTS
    push!(expr.args, sym)
end
eval(expr)

@doc """
Host

Enum type representing the animal species. Can be created with `parse(Host, s)`,
but the string `s` must match exactly.
""" Host 

danish(x::Host) = _HOSTS[Integer(x) + 1][2]
english(x::Host) = _HOSTS[Integer(x) + 1][3]

Base.print(io::IO, x::Host) = print(io, _HOSTS[Integer(x) + 1][2])

const _HOST_DICT = Dict(v[2] => Host(i-1) for (i, v) in enumerate(_HOSTS))
function Base.parse(::Type{Host}, s::AbstractString)
    v = get(_HOST_DICT, s, nothing)
    v === nothing ? error("Cannot parse \"", s, "\" as Host") : v
end

export Host
end # Module