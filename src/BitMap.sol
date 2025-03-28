// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BitmapStorage {
    uint256 private bitmap;

    // Store a byte in a specific slot (0-31)
    function setByte(uint8 slot, uint8 value) external {
        require(slot < 32, "Slot out of range");
        require(value <= 255, "Value out of range");

        // Clear the target slot
        uint256 clearMask = ~(uint256(0xFF) << (slot * 8));
        bitmap = bitmap & clearMask;

        // Set the new value
        bitmap |= uint256(value) << (slot * 8);
    }

    // Get the byte stored in a specific slot (0-31)
    function getByte(uint8 slot) external view returns (uint8) {
        require(slot < 32, "Slot out of range");

        return uint8((bitmap >> (slot * 8)) & 0xFF);
    }

    // Retrieve all 32 bytes as an array
    function getAllBytes() external view returns (uint8[32] memory) {
        uint8[32] memory values;

        for (uint8 i = 0; i < 32; i++) {
            values[i] = uint8((bitmap >> (i * 8)) & 0xFF);
        }

        return values;
    }

    // Get the raw bitmap value
    function getBitmap() external view returns (uint256) {
        return bitmap;
    }
} 
