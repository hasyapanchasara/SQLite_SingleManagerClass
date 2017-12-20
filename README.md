# SQLite_SingleManagerClass

SQLite SingleManagerClass and use of FMDB

- SingleTonManager class
- Swift language
- Use of FMDB
- Create database
- Insert, update, delete & select operations


# Implementation step

- Create your .db file
- Add freamework libsqlite3.tbd
- Drag and drop LocalDatabase.swift file into your project



# Method to create database

```
LocalDatabase.sharedInstance.methodToCreateDatabase()
```


# Method to insert, update and delete data

```
LocalDatabase.sharedInstance.methodToInsertUpdateDeleteData("INSERT INTO CONTACTS_TABLE (name, address, phone) VALUES ('Satyam Mall', 'Brainvire', 0085)", completion: { (completed) in
    if completed
    {
        print("Data updated successfully")
    }
    else
    {
        print("Fail while data updation")
    }
})
```


# Method to select data

```
LocalDatabase.sharedInstance.methodToSelectData("SELECT * FROM CONTACTS_TABLE", completion: { (dataReturned) in
    print(dataReturned)
})
```

![simulator screen shot 18-jan-2017 1 02 22 pm](https://cloud.githubusercontent.com/assets/23353196/22055014/ea1c9c90-dd7e-11e6-9b72-6fef4c931686.png)





<a href="https://www.paypal.me/hasya25/1"><img src="https://user-images.githubusercontent.com/23353196/30152617-4567dbc4-93d1-11e7-9b3a-20a9c92c1f50.png" style="max-width:100%;" width="170"></a>
