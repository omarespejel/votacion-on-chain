%lang starknet
from starkware.cairo.common.cairo_builtins import HashBuiltin

from src.votantes import (
    ConteoVotos, 
    estado_votacion, 
    InfoVotante,
    info_votante
)
 
# @dev Retorna el estado de la votación
# @implicit syscall_ptr (felt*)
# @implicit pedersen_ptr (HashBuiltin*)
# @implicit range_check_ptr
# @return estado (ConteoVotos): estado actual de la votación
@view
func get_estado_votacion{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr
}() -> (estado: ConteoVotos):
    let (estado) = estado_votacion.read()
    return (estado)
end


# @dev Retorna el estado de un votante
# @implicit syscall_ptr (felt*)
# @implicit pedersen_ptr (HashBuiltin*)
# @implicit range_check_ptr
# @return estado (InfoVotante): estado actual de un votante
@view
func get_estado_votante{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr
}(user_address: felt) -> (estado: InfoVotante):
    let (estado) = info_votante.read(user_address)
    return(estado)
end