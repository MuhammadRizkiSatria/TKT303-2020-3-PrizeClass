
package com.example.prizeclass;

import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.app.Dialog;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseAppLifecycleListener;
import com.google.firebase.FirebaseOptions;

public class MainActivity extends AppCompatActivity {
    Button start_input;





    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        start_input = (Button) findViewById(R.id.start_input);

        start_input.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                showSign();

            }
        });
    }

    public void showSign() {
        AlertDialog.Builder start_input = new AlertDialog.Builder(MainActivity.this);

        LayoutInflater inflater = this.getLayoutInflater();
        View pop_up_input_kode = inflater.inflate(R.layout.activity_pop_up_input_kode, null);

        start_input.setView(pop_up_input_kode);
        start_input.show();
    }
}


