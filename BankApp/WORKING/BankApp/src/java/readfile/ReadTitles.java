package readfile;

public class ReadTitles {
    // String used for SQL Code to link database info
    String sqlAll;
    // User Element Selection
    int p = 0;
    
    public void ReadTitles(int p){
        this.p = p;
        // If-ElseIf-Else statements for SQL statements thorughout program.
        if(p == 1){
            sqlAll = "date";
        }
        else if(p == 2){
            sqlAll = "info";
        }
        else if(p == 3){
            sqlAll = "amount";
        }
        else if(p == 4){
            sqlAll = "lastName";
        }
        else if(p == 5){
            sqlAll = "address";
        }
        else if(p == 6){
            sqlAll = "city";
        }
        else if(p == 7){
            sqlAll = "state";
        }
        else if(p == 8){
            sqlAll = "zipcode";
        }
        else if(p == 9){
            sqlAll = "phoneNumber";
        }
        else if(p == 10){
            sqlAll = "email";
        }
        else if(p == 11){
            sqlAll = "pinNum";
        }
        else if(p == 12){
            sqlAll = "imageID";
        }
        else if(p == 13){
            sqlAll = "identifier";
        }
        else if(p == 14){
            sqlAll = "ID";
        }
        else if(p == 15){
            sqlAll = "totalTime";
        }
        else if(p == 16){
            sqlAll = "status";
        }
        else if(p == 17){
            sqlAll = "timeIn";
        }
        else if(p == 18){
            sqlAll = "timeOut";
        }
        else if(p == 19){
            sqlAll = "wrong";
        }
        else if(p == 20){
            sqlAll = "auth";
        }
        else if(p == 21){
            sqlAll = "user";
        }
        else if(p == 22){
            sqlAll = "admin";
        }
        else{
            sqlAll = "NULL";
        }        
    }
    // Return String
    public String getSQLTitles(){
        return sqlAll;
    }
}

