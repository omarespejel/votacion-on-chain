%lang starknet
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
 
from src.votantes import (
    InfoVotante, 
    info_votante, 
    estado_votacion, 
    ConteoVotos
)
from src.utils import assert_permitido_votar, assert_did_not_vote

# @dev Dado un voto, revisa si el caller puede votar y actualiza el estado de la
# votación, y el status del votante.
# @implicit syscall_ptr (felt*)
# @implicit pedersen_ptr (HashBuiltin*)
# @implicit range_check_ptr
# @param vote (felt): voto 0 o 1
@external
func vote{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr
}(vote : felt) -> ():
    alloc_locals
    # Saber si un votante ya votó y continuar si no ha votado
    let (caller) = get_caller_address()
    let (info) = info_votante.read(caller)
    assert_permitido_votar(info)
    assert_did_not_vote(info)

    # Marcar que el votante ya votón y actualizar en el storage
    let info_actualizada = InfoVotante(
        ya_voto=1,
        permitido_votar=1,
    )
    info_votante.write(caller, info_actualizada)

    # Actualizar el estado de la votación con el nuevo voto
    let (state) = estado_votacion.read()
    local estado_votacion_actualizada : ConteoVotos
    if vote == 0:
        assert estado_votacion_actualizada.votos_no = state.votos_no + 1
        assert estado_votacion_actualizada.votos_si = state.votos_si
    end
    if vote == 1:
        assert estado_votacion_actualizada.votos_no = state.votos_no
        assert estado_votacion_actualizada.votos_si = state.votos_si + 1
    end
    estado_votacion.write(estado_votacion_actualizada)
    return ()
end