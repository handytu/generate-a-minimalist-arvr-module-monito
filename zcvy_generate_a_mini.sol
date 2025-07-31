pragma solidity ^0.8.0;

contract ARVRModuleMonitor {
    struct Module {
        string name;
        uint256 deviceId;
        uint256 lastSeen;
        uint256 batteryLevel;
        bool isConnected;
    }

    mapping(address => Module) public modules;

    event NewModuleAdded(address indexed owner, string name, uint256 deviceId);
    event ModuleUpdated(address indexed owner, uint256 lastSeen, uint256 batteryLevel, bool isConnected);

    function addModule(string memory _name, uint256 _deviceId) public {
        Module storage module = modules[msg.sender];
        module.name = _name;
        module.deviceId = _deviceId;
        module.lastSeen = block.timestamp;
        module.batteryLevel = 100;
        module.isConnected = true;

        emit NewModuleAdded(msg.sender, _name, _deviceId);
    }

    function updateModule(uint256 _lastSeen, uint256 _batteryLevel, bool _isConnected) public {
        Module storage module = modules[msg.sender];
        module.lastSeen = _lastSeen;
        module.batteryLevel = _batteryLevel;
        module.isConnected = _isConnected;

        emit ModuleUpdated(msg.sender, _lastSeen, _batteryLevel, _isConnected);
    }

    function getModule() public view returns (string memory, uint256, uint256, uint256, bool) {
        Module storage module = modules[msg.sender];
        return (module.name, module.deviceId, module.lastSeen, module.batteryLevel, module.isConnected);
    }
}