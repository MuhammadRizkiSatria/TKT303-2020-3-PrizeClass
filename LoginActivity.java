/*
 * Coding untuk bagian Login
 * dibagian ini akan meminta user memasukkan Username dan Password
 * ada dua tombol yang bisa digunakan, "Login" untuk melanjutkan ke halaman Beranda
 * dan "Daftar" untuk mendaftarkan akun baru pada Halaman Register
 */

package com.example.prizeclass;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class LoginActivity extends AppCompatActivity {
    DatabaseHelper db;
    Button login, register; // Ada dua Tombol yang terdapat pada Halaman ini
    EditText username, password; // Ada dua input yang bisa dimasukkan user pada halaman ini

    // Mengambil bagian Layout yang sesuai untuk bagian Login
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login); //Layou Login adalah activity_Login

        db = new DatabaseHelper(this);

        // Bagian yang bisa diakses user, dan dihubungkan dengan bagian Layout Login
        username = (EditText)findViewById(R.id.edtText_username);
        password = (EditText)findViewById(R.id.edtText_password);
        login = (Button)findViewById(R.id.btn_login);
        register = (Button)findViewById(R.id.btn_register);

        //Jika menekan Tombol Register, maka User akan dialihkan ke Halaman Register
        register.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent registerIntent = new Intent(LoginActivity.this, RegisterActivity.class);
                startActivity(registerIntent);
                finish();
            }
        });

        //Saat menekan Tombol Login, maka User akan menjalankan Method ini
        login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String strUsername = username.getText().toString();
                String strPassword = password.getText().toString();
                Boolean masuk = db.checkLogin(strUsername, strPassword);
                if (masuk == true) {
                    Boolean updateSession = db.upgradeSession("ada", 1);

                    // Saat "Username" dan "Password" benar, maka user akan dialihkan ke halaman Beranda
                    if (updateSession == true) {
                        Toast.makeText(getApplicationContext(), "Berhasil Masuk", Toast.LENGTH_SHORT).show();
                        Intent mainIntent = new Intent(LoginActivity.this, MainActivity.class);
                        startActivity(mainIntent);
                        finish();
                    }
                }

                // Saat "Username" dan "Password" salah, User akan mendapat pesan "Username atau Password Salah"
                else {
                    Toast.makeText(getApplicationContext(), "Username atau Password Salah", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }
}
