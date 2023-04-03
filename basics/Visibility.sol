// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// visibility
// private - only inside contract
// internal - only inside contract and child contracts
// public - inside and outside contract
// external - only from outside contract
contract VisibilitySample {
    uint256 private x = 0; // only accessible in this contract
    uint256 internal y = 1; // accessible by this contract and child contracts
    uint256 public z = 2; // accessible by any contract

    // uint256 external zz = 3; // DOES NOT COMPILE.

    function privateFunc() private pure returns (uint256) {
        return 0;
    }

    function internalFunc() internal pure returns (uint256) {
        return 1;
    }

    function publicFunc() public pure returns (uint256) {
        return 2;
    }

    function externalFunc() external pure returns (uint256) {
        return 3;
    }

    function parentExample() external view {
        x + y + z; // all variables are accessible

        privateFunc();
        internalFunc();
        publicFunc();
        // externalFunc(); // external can not be accessible within the same contract

        this.externalFunc(); // this works but inefficient. Do not use this!
    }
}

/// @title contract inherits from VisibilitySample
contract ChildContract is VisibilitySample {
    function childExample() external view {
        // x parent's private variable is not accessible
        y + z; // only internal and public variables are accessible

        internalFunc(); // parent's internal function
        publicFunc(); // parent's public function
        // externalFunc(); // parent's external function is not accessible
    }
}

/// @title contract which is external
contract ExternalContract {
    function externalExample(address _ca) external view {
        VisibilitySample vs = VisibilitySample(_ca);
        vs.z; // only public variable is accessible

        vs.publicFunc(); // public func is accessible from external contract
        vs.externalFunc(); // external func is accessible from external contract
    }
}
