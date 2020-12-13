package com.example.prizeclassapp;

import androidx.appcompat.app.AppCompatActivity;

import android.database.DatabaseErrorHandler;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    private DatabaseReference myDatabase;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Object firebaseDatabase;

        myDatabase = firebaseDatabase.getInstance().getReference(SEARCH_SERVICE, "Message");

        TextView mytext = findViewById(R.id.editTextTextPersonName3);

        myDatabase.addValueEventListener(new ValueEventListener) {
            @Override
                    public void onDataChange(DataSnapshot dataSnapshot){
            }
            @Override
                    public void onCancelled(DatabaseError databaseError){

            }
        }
    }
}