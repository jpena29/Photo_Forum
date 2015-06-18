/* GROUP 8 */
CREATE TABLE userAccounts /*tuples in this table cannot be deleted*/
(
    fname varchar(25) NOT NULL,
    lname varchar(25) NOT NULL,
    username varchar(25) NOT NULL UNIQUE,
    password varchar(25) NOT NULL,
    email varchar(25) NOT NULL PRIMARY KEY,
    address varchar(50),
    phone int,
    bday int,
    homepage varchar(50)
);


CREATE TABLE reguser
(
    userAccounts_username varchar(25) PRIMARY KEY,
    photoViews int NOT NULL,
    photoLikes int NOT NULL,
    threadLikes int NOT NULL, 
    threadViews int NOT NULL,
    postLikes int NOT NULL,
    interests varchar(20),
    
    INDEX(userAccounts_username),
    FOREIGN KEY (userAccounts_username)
      REFERENCES userAccounts(username)
      ON UPDATE CASCADE
);


CREATE TABLE adminmoderator
(
    userAccounts_username varchar(25) PRIMARY KEY,
    status varchar(25),

    INDEX (userAccounts_username),
    FOREIGN KEY (userAccounts_username) 
      REFERENCES userAccounts(username)
      ON UPDATE CASCADE
);

CREATE TABLE ads	
(
    adID int auto_increment PRIMARY KEY,
    companyID int NOT NULL,
    productID int NOT NULL,
    spID int NOT NULL,
    targetsusername varchar(25),
    date_posted int NOT NULL,
    date_expires int NOT NULL,
    description varchar(100),
    keywords varchar(15),
    views int NOT NULL,

    INDEX(companyID),
    INDEX(productID),
    INDEX(spID),
    INDEX(targetsusername),
    FOREIGN KEY (companyID) 
      REFERENCES company(companyID)
      ON UPDATE CASCADE,
    FOREIGN KEY (productID) 
      REFERENCES product(productID)
      ON UPDATE CASCADE,
    FOREIGN KEY (spID) 
      REFERENCES salesPerson(spID)
      ON UPDATE CASCADE,
    FOREIGN KEY (targetsusername) 
      REFERENCES userAccounts(username)
      ON UPDATE CASCADE
);


CREATE TABLE company /*tuples in this table cannot be deleted*/
(
    companyID int auto_increment PRIMARY KEY,
    name varchar(20) NOT NULL,
    location varchar(50) NOT NULL,
    phone int NOT NULL,
    fax int,
    homepage varchar(50),
    numofproduct int
);


CREATE TABLE islogout /*need to store when they logout for security purposes*/
(
    userAccounts_username varchar(25) PRIMARY KEY,
    date int NOT NULL,
    time int NOT NULL,

    INDEX (userAccounts_username),
    FOREIGN KEY (userAccounts_username) 
      REFERENCES userAccounts(username)
      ON UPDATE CASCADE
);


CREATE TABLE message
(
    msgID int auto_increment PRIMARY KEY,
    send_email varchar(25) NOT NULL,
    receive_email varchar(25) NOT NULL,
    subject varchar(100),
    msgbody varchar(1000) NOT NULL,
    date int NOT NULL,
    time int NOT NULL,

    INDEX(send_email, receive_email),
    FOREIGN KEY (send_email) 
      REFERENCES userAccounts(email)
      ON UPDATE CASCADE,
    FOREIGN KEY (receive_email) 
      REFERENCES userAccounts(email)
      ON UPDATE CASCADE
);


CREATE TABLE picture
(
    pictureID int auto_increment PRIMARY KEY,
    userAccounts_username varchar(25) NOT NULL,
    title varchar(25), 
    tags varchar(25) NOT NULL,
    date int NOT NULL,
    time int NOT NULL,
    likes int NOT NULL,
    dislikes int NOT NULL,
    views int NOT NULL,

    INDEX(userAccounts_username),
    FOREIGN KEY (userAccounts_username)
      REFERENCES userAccounts(username)
      ON UPDATE CASCADE
);


CREATE TABLE post /*to comment on a post users have to create a post, posts are comments in a thread*/
(
    postID int auto_increment PRIMARY KEY,
    threadID int,
    userAccounts_username varchar(25) NOT NULL,
    string varchar(500) NOT NULL,
    date int NOT NULL,
    time int NOT NULL,
    likes int NOT NULL,
    dislikes int NOT NULL,
    checkFlag int NOT NULL,

    INDEX(userAccounts_username),
    INDEX(threadID),
    FOREIGN KEY (userAccounts_username)
      REFERENCES userAccounts(username)
      ON UPDATE CASCADE,
    FOREIGN KEY (threadID)
      REFERENCES thread(threadID)
      ON UPDATE CASCADE
      ON DELETE SET NULL
);


CREATE TABLE product /*tuples in this table cannot be deleted*/
(
    productID int auto_increment PRIMARY KEY,
    companyID int NOT NULL,
    productname varchar(25) NOT NULL,
    category varchar(15) NOT NULL,
    quantity int NOT NULL,
    sold int NOT NULL,
    pricePerItem double NOT NULL,
    description varchar(100),
    noofads int,
    noofpurchases int,
    date_discontinued int,

    INDEX(companyID),
    FOREIGN KEY (companyID)
      REFERENCES company(companyID)
      ON UPDATE CASCADE
);


CREATE TABLE purchase /*tuples in this table cannot be deleted*/
(
    purchaseID int auto_increment PRIMARY KEY,
    productID int NOT NULL,
    userAccounts_username varchar(25) NOT NULL,
    userAccounts_email varchar(25) NOT NULL,
    purchase_quantity int NOT NULL,
    cost double NOT NULL,
    date int NOT NULL,
    time int NOT NULL,

    INDEX(productID),
    INDEX(userAccounts_username, userAccounts_email),
    FOREIGN KEY (productID) 
      REFERENCES product(productID)
      ON UPDATE CASCADE,
    FOREIGN KEY(userAccounts_username, userAccounts_email) 
      REFERENCES userAccounts(username, email)
      ON UPDATE CASCADE
);


CREATE TABLE salesPerson /*tuples in this table cannot be deleted*/
(
    spID int auto_increment PRIMARY KEY,
    userAccounts_username varchar(25) NOT NULL,
    ssn int NOT NULL,
    salary double NOT NULL,
    sales double NOT NULL,
    sex varchar(1) NOT NULL,
    date_hire int NOT NULL,
    date_left int NOT NULL,

    INDEX(userAccounts_username),
    FOREIGN KEY (userAccounts_username)
      REFERENCES userAccounts(username)
      ON UPDATE CASCADE
);


CREATE TABLE salesReport /*tuples in this table cannot be deleted*/
(
    srID int auto_increment PRIMARY KEY,
    spID int NOT NULL,
    byMonth varchar(2000) NOT NULL,
    byProducts varchar(2000) NOT NULL,
    byCustomer varchar(2000) NOT NULL,
    date int NOT NULL,
    time int NOT NULL,

    INDEX(spID),
    FOREIGN KEY (spID) 
      REFERENCES salesPerson(spID)
      ON UPDATE CASCADE
);


CREATE TABLE securityQuestion /*need to store this for security purposes*/
(
    userAccounts_username varchar(25) NOT NULL,
    userAccounts_email varchar(25) NOT NULL,
    question varchar(100) NOT NULL,
    answer varchar(100) NOT NULL,
    date int NOT NULL,
    time int NOT NULL,

    PRIMARY KEY(userAccounts_username, userAccounts_email),
    INDEX(userAccounts_username, userAccounts_email),
    FOREIGN KEY (userAccounts_username, userAccounts_email) 
      REFERENCES userAccounts(username, email)
      ON UPDATE CASCADE
);


CREATE TABLE thread
(
    threadID int auto_increment PRIMARY KEY,
    topicID int,
    userAccounts_username varchar(25) NOT NULL,
    title varchar(25) NOT NULL, 
    tags varchar(25),
    date int NOT NULL,
    time int NOT NULL,
    likes int NOT NULL,
    dislikes int NOT NULL,
    views int NOT NULL,
    noofpost int NOT NULL,

    INDEX(userAccounts_username),
    INDEX(topicID),
    FOREIGN KEY (userAccounts_username)
      REFERENCES userAccounts(username)
      ON UPDATE CASCADE,
    FOREIGN KEY (topicID)
      REFERENCES topic(topicID)
      ON UPDATE CASCADE
      ON DELETE SET NULL
);


CREATE TABLE topic
(
    topicID int auto_increment PRIMARY KEY,
    adminmoderator_username varchar(25),
    title varchar(25) NOT NULL, 
    tags varchar(25) NOT NULL,
    date int NOT NULL,
    time int NOT NULL,
    views int NOT NULL,
    noofthread int NOT NULL,

    INDEX(adminmoderator_username),
    FOREIGN KEY (adminmoderator_username)
      REFERENCES adminmoderator(userAccounts_username)
      ON UPDATE CASCADE
      ON DELETE SET NULL
);

