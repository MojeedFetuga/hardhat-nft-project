// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract OnchainSVGNFT is ERC721, Ownable {
    using Strings for uint256;

    uint256 private _nextTokenId;

    constructor() ERC721("OnchainSVGNFT", "OSVG") Ownable(msg.sender){}

    function mintNFT(address recipient) public onlyOwner returns (uint256) {
        uint256 tokenId = _nextTokenId;
        _safeMint(recipient, tokenId);
        _nextTokenId++;
        return tokenId;
    }

    function tokenExists(uint256 tokenId) public view returns (bool) {
        return _ownerOf(tokenId) != address(0);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(tokenExists(tokenId), "Token does not exist");

        string memory svg = generateSVG(tokenId);
        string memory metadata = string(
            abi.encodePacked(
                '{"name": "OnchainSVGNFT #', tokenId.toString(),
                '", "description": "Fully on-chain NFT with SVG artwork.", "image": "data:image/svg+xml;base64,',
                Base64.encode(bytes(svg)),
                '"}'
            )
        );

        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(bytes(metadata))));
    }

    function generateSVG(uint256 tokenId) internal pure returns (string memory) {
        return string(
            abi.encodePacked(
                '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 500">',
                '<rect width="100%" height="100%" fill="blue"/>',
                '<text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" ',
                'font-size="40" fill="white">#', tokenId.toString(), '</text>',
                '</svg>'
            )
        );
    }
}
