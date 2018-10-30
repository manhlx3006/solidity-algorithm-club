pragma solidity 0.4.25;

library StringExtension {
    /*
    Convert given string to lowercased
    https://vi.wikipedia.org/wiki/ASCII
    */
    function toLowercased(string from) public pure returns (string to) {
        bytes memory b = bytes(from);
        for(uint i = 0; i < b.length; i++) {
            if (b[i] >= 0x41 && b[i] <= 0x5A) {
                b[i] = byte(uint(b[i]) + 0x20);
            }
        }
        to = string(b);
        return to;
    }

    /*
    Convert given string to uppercased
    https://vi.wikipedia.org/wiki/ASCII
    */
    function toUppercased(string from) public pure returns (string to) {
        bytes memory b = bytes(from);
        for(uint i = 0; i < b.length; i++) {
            if (b[i] >= 0x61 && b[i] <= 0x7A) {
                b[i] = byte(uint(b[i]) - 0x20);
            }
        }
        to = string(b);
        return to;
    }

    /*
    Get substring of a string from startIndex to endIndex inclusive (bytes index)
    index starts from 0
    */
    function substring(string from, uint startIndex, uint endIndex) public pure returns (string to) {
        bytes memory stringBytes = bytes(from);
        // endIndex should be in range of string, get a valid end index
        uint validEnd = endIndex >= stringBytes.length ? stringBytes.length - 1 : endIndex;
        uint len = validEnd >= startIndex ? validEnd - startIndex + 1 : 0;
        bytes memory toStringBytes = new bytes(len);
        for(uint i = startIndex; i <= validEnd; i++) {
            toStringBytes[i - startIndex] = stringBytes[i];
        }
        to = string(toStringBytes);
        return to;
    }

    /*
    Get suffix of a string given len of suffix
    */
    function suffix(string from, uint len) public pure returns (string to) {
        uint length = bytes(from).length;
        uint start = length >= len ? length - len : 0;
        to = substring(from, start, bytes(from).length - 1);
        return to;
    }

    /*
    Get substring of a string end at endIndex
    */
    function prefix(string from, uint len) public pure returns (string to) {
        uint length = bytes(from).length;
        uint end = len <= length ? len : length;
        to = substring(from, 0, end - 1);
        return to;
    }

    /*
    Check if a string starts with another string
    */
    function startsWith(string self, string other) public pure returns (bool) {
        if (bytes(self).length < bytes(other).length) { return false; }
        bytes memory selfBytes = bytes(self);
        bytes memory otherBytes = bytes(other);
        for(uint i = 0; i < otherBytes.length; i++) {
            if (selfBytes[i] != otherBytes[i]) { return false; }   
        }
        return true;
    }

    /*
    Check if a string ends with another string
    */
    function endsWith(string self, string other) public pure returns (bool) {
        if (bytes(self).length < bytes(other).length) { return false; }
        bytes memory selfBytes = bytes(self);
        bytes memory otherBytes = bytes(other);
        uint offset = selfBytes.length - otherBytes.length;
        for(uint i = 0; i < otherBytes.length; i++) {
            if (selfBytes[i + offset] != otherBytes[i]) { return false; }   
        }
        return true;
    }
}