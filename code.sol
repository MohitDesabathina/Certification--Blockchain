pragma solidity^0.5.00;

contract cert{
    //addapprover
    //userlogin
    //create certificate
    struct Certificate {
        bytes32 id;
        string certname;
        string approvedby;
        string approveddate;
        string dept;
        bool approve;
        address creat;
    }
    
    struct User {
        uint id;
        string name;
        string password;
        bool doesExist;
    }
    
    struct Approver {
        uint id;
        string name;
        bool doesExist;
    }
    address admin; //university
    constructor() public payable {
        admin = msg.sender;
    }
    
    event Addapproval(uint _id);
    event CreateUser(uint _id);
    event CreateCertificate(bytes32 _certId);
    event VerifyCertificate(bytes32 _certId);

    //Adding approval
    mapping(address => Approver) public approverList;
    uint public approvercount;
    function addapproval(string memory _name,address appaddress) public{
        require(msg.sender == admin);//admin or not
        require(approverList[msg.sender].doesExist==false,"Already exist");//new or not
        approvercount++;
        approverList[appaddress]= Approver(approvercount,_name,true);
    }

    //creating user 
    mapping(address => User) public userList;
    uint userid;
    function createUser(string memory _name,string memory password) public {
        require(userList[msg.sender].doesExist == false, "Already exist");
        userid++;
        userList[msg.sender] = User(userid,_name,password, true);
    
    }
    
    
    
    uint certIndex = 0;
    mapping(uint => Certificate) public certificateList;
    mapping(address => bytes32[]) public certificateListByAddress;
    mapping(bytes32 => Certificate) public certificateListById;
    
    function createCertificate(uint id,string memory certname,string memory approvedby,string memory approveddate,string  memory dept,bool approve,address creat) public{
        bytes32 CertId = keccak256(abi.encodePacked(certname, msg.sender));
        
        Certificate memory newCert = Certificate(CertId,certname,approvedby,approveddate,dept,true,msg.sender);
        certificateList[certIndex] = newCert;
        certificateListByAddress[msg.sender].push(CertId);
        certificateListById[CertId] = newCert;
        certIndex++;
    
    }
         
}
