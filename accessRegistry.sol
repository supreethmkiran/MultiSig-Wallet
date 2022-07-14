// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./multisig.sol";

contract accessRegistry is MultiSigWallet{
    address private _owner = msg.sender;

    function addAddress(address _address) public onlyOwner {
        // owners.push(_address);
        // isOwner[_address] = true;
        // sixtypercent = 6 * owners.length /10;
        // numConfirmationsRequired = sixtypercent;
        uint flag =0;
        for (uint i = 0; i < owners.length; i++) {
            address owner = owners[i];

            require(owner != address(0), "invalid owner");
            if (owner == _address) {
                flag = 1;
            }
        }
        if (flag == 0) {
            isOwner[_address] = true;
            owners.push(_address);
        }
        sixtypercent = 6 * owners.length /10;
        numConfirmationsRequired = sixtypercent;
    }

    function revokeAccess(address _address) public onlyOwner {
        isOwner[_address] = false;
    }

    function renounceAccess(address _address) public onlyOwner {
        uint position = 0;
        for (uint i = 0; i<owners.length; i++) {
            if(owners[i] == _address) {
                position = i;
            }
        }
        isOwner[_address] = false;
        delete owners[position];
    }

    function transferSignatory(address to, address from) public onlyOwner {
        uint flag = 0;
        for (uint i = 0; i < owners.length; i++) {
            address owner = owners[i];

            require(owner != address(0), "invalid owner");
            if (isOwner[to]) {
                flag = 1;
                break;
            }

            
        }
        if (flag == 0 ) {
            isOwner[to] = true;
            owners.push(to);
            isOwner[from] = false;
        }
        
    }
}