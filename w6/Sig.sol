// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/*
To verify a signed message, it takes 4 steps
1. message to sign
2. hash(message)
3. sign(hash(message), private key) | offchain
4. ecrecover(hash(message), signature) == signer
*/
contract VerifySignature {
    /// @dev verify the signature is signed by the signer
    /// @param _signer address signed the message
    /// @param _message the plain text to be signed
    /// @param _sig signature to be verified
    function verify(
        address _signer,
        string calldata _message,
        bytes calldata _sig
    ) external pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    /// @dev The hashed message to be signed
    /// @param _message the plain text
    function getMessageHash(string calldata _message)
        public
        pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(_message));
    }

    /// @dev Get Ethereum Signed message hash to verify the signature
    /// @param _messageHash message hash which is used to sign
    function getEthSignedMessageHash(bytes32 _messageHash)
        public
        pure
        returns (bytes32)
    {
        return
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    _messageHash
                )
            );
    }

    /// @dev Recover the signer from the hash and signature
    function recover(bytes32 _ethSignedMessageHash, bytes calldata _sig)
        public
        pure
        returns (address)
    {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    /// @dev split the signature into 3 parts (r, s, v)
    function _split(bytes memory _sig)
        internal
        pure
        returns (
            bytes32 r,
            bytes32 s,
            uint8 v
        )
    {
        // the length of the signature has to be 65 (r: 32 bytes, s: 32 bytes, v: 1 byte)
        require(_sig.length == 65, "invalid signature length");

        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96))) // only need the first byte
        }
    }
}
