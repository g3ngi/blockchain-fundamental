// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract HospitalRecordList {
    // TODO: create a smart contract to enable create, read, and delete patient data
    // Patient data consists of:
    // 1. Name
    // 2. Gender
    // 3. Date of Birth
    
    struct Patient {
        uint id;
        string name;
        string gender;
        string dateOfBirth;
    }

    // format: mapping([tipe data key] => [tipe data value])
    mapping(uint => Patient) public patientsa;
    uint public patientsCount;

    constructor() public {
        patientsCount = 0;
    }

    function addPatient(string memory name, string memory gender, string memory dateOfBirth) public {
        
        patients[patientsCount] = Patient(patientsCount + 1, name, gender, dateOfBirth);
        patientsCount++;

    }

    function deletePatient(uint idx) public {
        for(uint i = idx; i < patientsCount - 1; i++) {
            patients[i] = patients[i + 1];
        }
        patientsCount--;
    }

}