pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;


import "2_Ownable.sol";

contract LiterAlly is Ownable{
    
    
    event BinAdded(address aadharMappedAddress);
    
    event organizationCreated(uint id, string organizationName, string organizationType);
    
    event TransactionAdded(string title, string gpa);
    
    event recordVerified(string name, uint recordID);
    
    event RecycleAdded(string title, uint filedInYear);
    
    event BinDump(string field, string title);
    
    event extraAllyRewardAdded(string field, string level);
    
   
    struct Record{
        string title;
        string gpa;
        string ipfsHash;
        uint fromOrgID;
        bool isVerifiedByOrganization;
    }
    
  
    struct ResearchPaper{
        string researchField;
        string title;
        string ipfsHash;
    }

    //Struct for any achievemets in extraCurricular activities
    struct extraCurricularAchievement {
        string field;   //Field of achievement i.e. sports, cultural etc
        string level;   // level of achievement i.e. regional, state, national etc
        string ipfsHash;// hash from ipfs
        
    }
    
    //Struct for any patents filed by the Student.
    struct Patent{
        string title;
        uint filedInYear;
        string ipfsHash;
    }


    
    //Struct for a organization
    struct Organization{
        uint orgCount;       //Organization ID
        string name;  //Name of the organization
        string typeOfOrganization;  //Type of Organization i.e. if it is a highSchool or a university
        uint orgUID;    
    }
    
    


    //Struct of a student.
    struct Student{

        //Count of number of academic titles held, Number of degrees held by student.
        uint academicRecords;  
        
        // Record of all the academic titles/degrees held by student.
        mapping(uint=>AcademicRecord) academics; 
        
        //Count of number of ResearchPaper published.
        uint noOfPapersPublished;  
        
        //Record of all the research papers published.
        mapping(uint=>ResearchPaper) papersPublished;
        
        //Count of total number of patents held by student.
        uint noOfPatents; 
        
        //Record of all patents.
        mapping(uint=>Patent) patentsFiled; 
        
        //Count of total number CoCurricular Achievements.
        uint noOfExtraCurricularAchievements;

        //All of patents held by student.
        mapping(uint=>extraCurricularAchievement) extraCurricularAchievements; 
    
    }
    
    
    
    uint organizationCount; //Count of total number organizations.
    
    
    constructor() public {
        organizationCount = 0;
    }
    
    
    mapping(address=>Organization) public addressToOrganization; //Map of organization id to Organization. 

    mapping(uint => Organization) public uintToOrganization;


    mapping(uint => Organization) public orgUIDToOrganization;

    
    mapping(address=>Student) public addressToStudent; //Map of address to Student and the address inturn is mapped on UID stored on backend database.
    
    
    //Function to register student on Blockchain. 
    function addStudent( address _userAddress) public returns(bool){
        Student memory _student = Student(0,0,0,0);
        addressToStudent[_userAddress] = _student;
        emit studentAdded(_userAddress);
        return true;
    }    
    
    //function to add Organization can be only called by owner/ some governing authority
    function addOrganization(string memory _name, string memory _type, address orgAddress,uint orgUID ) public onlyOwner(msg.sender) {
        
        addressToOrganization[orgAddress] = Organization(organizationCount, _name, _type,orgUID );
        uintToOrganization[organizationCount] = Organization(organizationCount, _name, _type,orgUID );
        orgUIDToOrganization[orgUID] = Organization(organizationCount, _name, _type,orgUID );
        organizationCount++;
        emit organizationCreated(organizationCount-1, _name, _type);
    }
    
    //Function to add academic record in a persons profile.
    function addAcademicRecord(string memory _academicTitle, string memory _gpa, string memory _ipfsHash, uint _orgID, address _studentAddress ) public {
        
        Student storage _student = addressToStudent[_studentAddress];
        _student.academics[_student.academicRecords++] = AcademicRecord(_academicTitle, _gpa, _ipfsHash, _orgID, false);
        emit academicRecordAdded(_academicTitle, _gpa);
    
    }
    
  
    function addPatents(address _studentAddress, string memory _title, uint _filedInYear, string memory _ipfsHash) public {
        
        Student storage student = addressToStudent[_studentAddress];
        student.patentsFiled[student.noOfPatents++] = Patent(_title, _filedInYear, _ipfsHash);
        emit patentAdded(_title, _filedInYear);

    }
    
    
    function addResearchPapers(address _studentAddress, string memory _field, string memory _title, string memory _ipfsHash) public {
        
        Student storage student = addressToStudent[_studentAddress];
        student.papersPublished[student.noOfPapersPublished++] = ResearchPaper(_field,_title,_ipfsHash);
        emit paperAdded(_field,_title);
        
    }
  
  
    function addExtraCurricular(address _studentAddress, string memory _field, string memory _level, string memory _ipfsHash) public {

        Student storage student = addressToStudent[_studentAddress];
        student.extraCurricularAchievements[student.noOfExtraCurricularAchievements++] = extraCurricularAchievement(_field, _level, _ipfsHash);
        emit extraCurricularAdded(_field, _level);
    
    }
    
  
      function validateAcademicRecord(address _studentAddress, uint _recordID, address _orgAddress) public {
        
        uint orgID = addressToOrganization[_orgAddress].orgUID;
        uint StudentRecordOrgID = addressToStudent[_studentAddress].academics[_recordID].fromOrgID;
        require(orgID == StudentRecordOrgID);
        
        Student storage student = addressToStudent[_studentAddress];
        student.academics[_recordID].isVerifiedByOrganization = true;
        
        emit recordVerified(addressToStudent[_studentAddress].academics[_recordID].title, _recordID);
    
    }
  
  
  
    function getStudent(address _studentAddress) public view
    returns(
            AcademicRecord[] memory academicRecord, 
            ResearchPaper[] memory researchPapers, 
            Patent[] memory patents,
            extraCurricularAchievement[] memory extraCurricular
            ){
        
       Student storage _student = addressToStudent[_studentAddress];
                academicRecord = new  AcademicRecord[](_student.academicRecords); 
         researchPapers = new ResearchPaper[](_student.noOfPapersPublished);
         patents = new Patent[](_student.noOfPatents);
         extraCurricular = new extraCurricularAchievement[](_student.noOfExtraCurricularAchievements);
       
         for(uint i=0 ; i < _student.academicRecords; i++){
            academicRecord[i] = _student.academics[i];
        }    

         for(uint i=0 ; i < _student.noOfPapersPublished; i++){
            researchPapers[i] = _student.papersPublished[i];
         }   
         
         
         for(uint i=0 ; i < _student.noOfPatents; i++){
            patents[i] = _student.patentsFiled[i];
         }   
         
         
         for(uint i=0 ; i < _student.noOfExtraCurricularAchievements; i++){
            extraCurricular[i] = _student.extraCurricularAchievements[i];
         }   
        
        
        return(academicRecord, researchPapers, patents, extraCurricular);
    }
    
    
    
    
    function getAllOrgs() public view returns(Organization[] memory) {
        
        Organization[] memory organizations = new Organization[](organizationCount);
        Organization memory org;
        for(uint i = 0; i < organizationCount; i++) {
            
             org = uintToOrganization[i];
            
            organizations[i] = org;
            
            
            
        }
        
        return organizations;
        
    }
    
    
}
