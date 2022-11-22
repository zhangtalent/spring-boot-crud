// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.6.10 <0.8.20;
pragma experimental ABIEncoderV2;

import "./Table.sol";

contract QuestionCRUD {

    event CreateResult(int256 count);
    event InsertResult(int256 count);
    event UpdateResult(int256 count);
    event RemoveResult(int256 count);

    TableManager constant tm = TableManager(address(0x1002));
    Table table;
    string constant TABLE_NAME = "question";
    constructor() public {
        // create table
        string[] memory columnNames = new string[](3);
        columnNames[0] = "question_answer";
        columnNames[1] = "question_status";
        columnNames[2] = "question_righter";
        TableInfo memory tf = TableInfo("question_id", columnNames);

        tm.createTable(TABLE_NAME, tf);
        address t_address = tm.openTable(TABLE_NAME);
        require(t_address != address(0x0), "create table failed");
        table = Table(t_address);
    }

    //select records
    function select(string memory question_id)
    public
    view
    returns (string memory, string memory, string memory, string memory)
    {
        Entry memory entry = table.select(question_id);

        string memory question_answer;
        string memory question_status;
        string memory question_righter;
        if (entry.fields.length == 2) {
            age = entry.fields[0];
            tel = entry.fields[1];
        }
        return (question_id, question_answer, question_status, question_righter);
    }

    //insert records
    function insert(string memory question_id, string memory question_answer, string memory question_status,  string memory question_righter)
    public
    returns (int256)
    {
        string[] memory columns = new string[](3);
        columns[0] = question_answer;
        columns[1] = question_status;
        columns[2] = question_righter;
        Entry memory entry = Entry(question_id, columns);

        int256 count = table.insert(entry);
        emit InsertResult(count);
        return count;
    }

    //update records
    function update(string memory question_id, string memory question_answer, string memory question_status,  string memory question_righter)
    public
    returns (int256)
    {
        UpdateField[] memory updateFields = new UpdateField[](3);
        updateFields[0] = UpdateField("question_answer", question_answer);
        updateFields[1] = UpdateField("question_status", question_status;
        updateFields[2] = UpdateField("question_righter", question_righter);

        int256 result = table.update(question_id, updateFields);
        emit UpdateResult(result);
        return result;
    }
    //remove records
    function remove(string memory question_id) public returns (int256) {
        int256 result = table.remove(name);
        emit RemoveResult(result);
        return result;
    }
}