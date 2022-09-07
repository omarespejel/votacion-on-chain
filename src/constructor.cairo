%lang starknet
from starkware.cairo.common.cairo_builtins import (
    HashBuiltin,
    SignatureBuiltin,
)
 
from src.utils import registrar_votantes
 
@constructor
func constructor{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(addresses_len: felt, addresses : felt*):
    alloc_locals
    registrar_votantes(addresses_len, addresses)
    return ()
end
