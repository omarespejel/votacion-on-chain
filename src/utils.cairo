%lang starknet 
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_not_zero

from src.votantes import InfoVotante, info_votante

# Función para preparar la lista de votantes.
# A cada votante se le asigna un struct InfoVotante
# indicando que no ha votado y que tiene permitido votar
func registrar_votantes{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
    }(addresses_len: felt, addresses : felt*):
    # No hay más votante, acaba recursión
    if addresses_len == 0:
        return ()
    end
    
    # Asignamos al votante en la dirección 'addresses[addresses_len - 1]'
    # un struct InfoVotante indicando que aún no ha votado y puede hacerlo 
    let votante_info = InfoVotante(
        ya_voto=0,
        permitido_votar=1,
    )
    info_votante.write(addresses[addresses_len - 1], votante_info) 
    
    # Pasar al siguiente votante, usamos recursión
    return registrar_votantes(addresses_len - 1, addresses)
end

# @dev Revisa si el caller tiene permitido votar
# @implicit syscall_ptr (felt*)
# @implicit pedersen_ptr (HashBuiltin*)
# @implicit range_check_ptr
# @param info (InfoVotante): struct que indica si el votante tiene permitido votar 
func assert_permitido_votar{
    syscall_ptr : felt*,
    #pedersen_ptr : HashBuiltin*,
    range_check_ptr
}(info : InfoVotante):

    with_attr error_message("Tu dirección no tiene permitido votar."):
        assert_not_zero(info.permitido_votar)
    end

    return ()
end

# @dev Revisa si el caller tiene permitido votar
# @implicit syscall_ptr (felt*)
# @implicit pedersen_ptr (HashBuiltin*)
# @implicit range_check_ptr
# @param info (InfoVotante): struct que indica si el votante tiene permitido votar 
func assert_did_not_vote{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr
}(info : InfoVotante):
    # We check if caller hasn't already voted
    with_attr error_message("Address already voted."):
        assert info.ya_voto = 0
    end
    return ()
end


