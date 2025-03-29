// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract RatingContract {
    address public owner;

    struct User {
        uint256 ratingSum;
        uint256 totalRatings;
    }

    mapping(address => User) private users;
    uint256 private userCount;
    mapping(address => bool) private userExists;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can add users");
        _;
    }

    function addUser(address newUser) public onlyOwner {
        if (userExists[newUser]) revert("User already exists.");

        userExists[newUser] = true;
        users[newUser] = User(0, 0);
        userCount++;
    }

    function addRating(address user, uint256 rating) public {
        require(userExists[user], "User not found");

        users[user].ratingSum += rating;
        users[user].totalRatings++;
    }

    function getIntegerRating(address user) public view returns (uint256) {
        require(userExists[user], "User not found");
        require(users[user].totalRatings > 0, "There are no ratings for this user yet");
        return users[user].ratingSum / users[user].totalRatings;
    }

    function getRatingParameters(address user) public view returns (uint256, uint256) {
        require(userExists[user], "User not found");
        return (users[user].ratingSum, users[user].totalRatings);
    }

    function getUserRating(address user) public view returns (uint256) {
        require(userExists[user], "User not found");
        return users[user].ratingSum;
    }

    function getUserSize() public view returns (uint256) {
        return userCount;
    }

    function getUserTimesVoted(address user) public view returns (uint256) {
        require(userExists[user], "User not found");
        return users[user].totalRatings;
    }
}
