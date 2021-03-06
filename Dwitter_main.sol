pragma solidity >=0.5.1;

contract DweetSent {
    uint public DweetCount;
    uint256 id;
    //uint public lCount = 0;
    //uint public rCount = 0 ;
    const Dweet_id;
    struct Dweet 
    {
    uint256 id;
	string dweetString;
    //address dweetAuthor;
	//string dweet_tags;
	//uint lCount;
    }
    struct User {
        uint age;
        string EthAddress;
        string email;
        uint index;
        uint DweetCount;
        //mapping (uint => _dweets) MyDweets;
        Dweet[] DweetsArray;
    }
    mapping (uint => Dweet) public MyDweets;
    mapping (address => User) user;
    mapping (address => _user) public _user;
    mapping (address => mapping (uint => bool)) public reported;
    mapping(uint => uint) public reportCount;
    mapping (address => mapping (uint => bool)) public liked;
    mapping (address => uint[]) public dweets_via_author;
    
    address [] userindex;
    address owner ;
    bool action = false;
    uint private totalDweetsCount;
    Dweet[] public RepoDweets;
    constructor() public {
        createDweet("Hello World");
        owner = msg.sender;
    }
        modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    event LogNewUser (address indexed Address, uint index, string EthAddress, uint age);
    event LogUpdateUser (address indexed Address, uint index, string EthAddress, uint age);
    event NewDweet (address indexed Address, uint );

    function isUser(address Address) public view returns (bool yesIsUser){
        if(userindex.length == 0) return false;
        return (userindex[users[Address].index] == Address); 
    }
    function addUser (string memory _EthAddress, uint _age) public returns (bool success)  {
        address Address = msg.sender;
        require(isUser(Address) == false); 
        users[Address].age = _age;
        users[Address].EthAddress = _EthAddress;
        users[Address].index = userindex.push(Address) - 1;
        emit LogNewUser(Address, users[Address].index, _EthAddress, _age);
        return true;
    }
    
    
    //function HashtagDweet(uint id, string memory _searchHashtag) view public dweetundelete
    //{
    //  Dweet memory dweets = dweets[id];
    //if (keccak256(abi.encodePacked(dweets.hashtag)) == keccak256(abi.encodePacked(_searchHashtag)))
    //{
    //  return (dweets.content, dweets.author, dw.timestamp, dweets.upvotes, dweets.report, dweets.hashtag);
    //}
        
    //}

    
    function getUser(address Address) public view returns(string memory EthAddress, uint age, uint index) {
        require(isUser(Address) == true);
        return (users[Address].EthAddress, users[Address].age, users[Address].index);
    }

    function createDweet(string memory _text) public returns (bool) {
        require (isUser(msg.sender) == true);
        uint dweet_index;
        dweet_index = RepoDweets.push(Dweet(_text, msg.sender))-1;

        uint _count = users[msg.sender].DweetCount;
        users[msg.sender].MyDweets[_count] = Dweet(_text, msg.sender);
        users[msg.sender].DweetCount ++;

        users[msg.sender].DweetsArray.push(Dweet(_text, msg.sender));

        return true;
    }
    
    function dweetsByUser(address Address) public view returns (Dweet[] memory) {
        require (isUser(Address) == true);
        //require(Dweet.deleted != true);
        Dweet[] memory _dweets = new Dweet[](users[Address].dweet_count);
        
        return users[Address].DweetsArray;
    }
    
    function totalDweetsByUser (address Address) public view returns (uint) {
        return users[Address].dweet_count;
    }

    function dweetByIndex(uint _id) public view returns (string memory _dweet, address _author) {
        _dweet = RepoDweets[_id].dweet_text;
        _author = RepoDweets[_id].dweet_author;
        return  (_dweet, _author);
    }
    
   event DweetCreated(
        uint id,
        string dweetString);
        
    function createDweet(string memory _dweetString) public onlyOwner{
       DweetCount+=1;
       //id +=1;
       MyDweets[DweetCount] = Dweet(DweetCount,_dweetString,0,false);
       emit DweetCreated(id,_dweetString);
       }
       
       event Reported(
           uint id,
           string dweetString);
           
     function reportOnce(uint _id, address _ethaddress) external {
        
         if (reported[_ethaddress][_id] != true ){
            reportDweet(_id,_ethaddress);
         }
     }
     
     function reportDweet(uint _id,address _ethaddress) internal {
        
         reportCount[_id]++;
         reported[_ethaddress][_id] = true;
         if ((reportCount[_id])>=10) {
            MyDweets[_id].dweetString = "";
          
         }
         emit Reported(id, MyDweets[_id].dweetString);
     }
     
    event profileUpdate (
        uint age,
        string email); 
    
    function editprofile(address _address, uint _age, string memory _email) public onlyOwner{
        
        require(_address == msg.sender);
        user[_address].age = _age;
        user[_address].email = _email;
        emit profileUpdate(user[_address].age ,user[_address].email);
    }
    
    event like(
        uint id,
        uint likeCount
        );
     function likeOnce(uint _id, address _ethaddress) external {
         
         if (liked[_ethaddress][_id] != true){
            likeDweet(_id,_ethaddress);
         }
     }
         
         function likeDweet(uint _id , address _ethaddress) internal {
             liked[_ethaddress][_id] = true;
             MyDweets[_id].lCount += 1;
             emit like(_id,MyDweets[_id].lCount);
         }
         
          function DeleteDweet(uint _id) public onlyOwner{
          MyDweets[_id].dweetString = "";
          MyDweets[_id].deleted = true;
    }
    
    
  
    }
    
    
     
