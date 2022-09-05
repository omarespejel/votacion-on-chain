%lang starknet

# struct que lleva el estado total de la votación
struct ConteoVotos:
    member votos_si : felt
    member votos_no : felt
end

# struct que indica si un votante ya votó y si tiene permitido votar
struct InfoVotante:
    member ya_voto : felt
    member permitido_votar : felt
end

# storage variable que no recibe ningún argumento y regresa el estado
# de la votación actualmente
@storage_var
func estado_votacion() -> (res : ConteoVotos):
end
 
# storage variable que recibe una dirección y retorna la información
# de ese votante 
@storage_var
func info_votante(user_address: felt) -> (res : InfoVotante):
end