// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BitMap.sol";

contract BitmapStorageTest is Test {
    BitmapStorage bitmapStorage;

    
    function setUp() public {
        bitmapStorage = new BitmapStorage();
    }

    function testSetAndGetByte() public {
        bitmapStorage.setByte(0, 42);
        uint8 value = bitmapStorage.getByte(0);
        assertEq(value, 42, "The value at slot 0 should be 42");

        bitmapStorage.setByte(1, 255);
        value = bitmapStorage.getByte(1);
        assertEq(value, 255, "The value at slot 1 should be 255");
    }

    function testGetAllBytes() public {
        bitmapStorage.setByte(0, 1);
        bitmapStorage.setByte(1, 2);
        bitmapStorage.setByte(2, 3);

        uint8[32] memory values = bitmapStorage.getAllBytes();
        assertEq(values[0], 1, "Slot 0 should be 1");
        assertEq(values[1], 2, "Slot 1 should be 2");
        assertEq(values[2], 3, "Slot 2 should be 3");
    }

    function testGetBitmap() public {
        bitmapStorage.setByte(0, 1);
        bitmapStorage.setByte(1, 2);
        uint256 bitmapValue = bitmapStorage.getBitmap();
        assertEq(bitmapValue, (1 << 0) | (2 << 8), "Bitmap value should match the set bytes");
    }

    function testSetByteOutOfRange() public {
        vm.expectRevert("Slot out of range");
        bitmapStorage.setByte(32, 1); // Slot 32 is out of range
    }

    function testGetByteOutOfRange() public {
        vm.expectRevert("Slot out of range");
        bitmapStorage.getByte(32); // Slot 32 is out of range
    }
}