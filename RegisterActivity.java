/*
* Coding untuk bagian Register
* dibagian ini akan meminta user mendaftarkan akun baru
* input yang diminta adalah "Username", "Password", dan "Konfirmasi Password"
* ada dua tombol yang bisa digunakan, "Login" untuk kembali ke halaman Login
* dan "Daftar" untuk mendaftarkan akun baru
* setelah "Daftar", user akan dialihkan ke Halaman Login secara Otomatis
 */

package com.example.prizeclass;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class RegisterActivity extends AppCompatActivity {
    DatabaseHelper db;
    Button login, register; // Banyaknya Tombol pada bagian Halaman Register
    EditText username, password, passwordConf; // Input Yang diperlukan untuk melakukan Pendaftaran

    // Mengambil bagian Layout yang sesuai untuk bagian Register
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        db = new DatabaseHelper(this);

        // Bagian yang bisa diakses user, dan dihubungkan dengan bagian Layout Register
        username = (EditText)findViewById(R.id.edtText_usernameRegist);
        password = (EditText)findViewById(R.id.edtText_passwordRegist);
        passwordConf = (EditText)findViewById(R.id.edtText_passwordConfRegist);
        login = (Button)findViewById(R.id.btn_loginRegist);
        register = (Button)findViewById(R.id.btn_registerRegist);

        // Bagian saat menekan tombol Login, akan dialihkan ke Halaman Login
        login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent loginIntent = new Intent(RegisterActivity.this, LoginActivity.class);
                startActivity(loginIntent);
                finish();
            }
        });

        //Bagian untuk tombol Daftar, diharuskan untuk mengisi bagian yang diminta
        register.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String strUsername = username.getText().toString();
                String strPassword = password.getText().toString();
                String strPasswordConf = passwordConf.getText().toString();
                if (strPassword.equals(strPasswordConf)) {
                    Boolean daftar = db.insertUser(strUsername, strPassword);

                    // Saat pendaftaran berhasil akan muncul pesan "Daftar Berhasil" dan kemudian dialihkan ke Halaman Login
                    if (daftar == true) {
                        Toast.makeText(getApplicationContext(), "Daftar Berhasil", Toast.LENGTH_SHORT).show();
                        Intent loginIntent = new Intent(RegisterActivity.this, LoginActivity.class);
                        startActivity(loginIntent);
                        finish();
                    }
                    // Saat pendaftaran Gagal, maka akan diharuskan untuk mengisi ulang pada halaman tersebut
                    else {
                        Toast.makeText(getApplicationContext(), "Daftar Gagal", Toast.LENGTH_SHORT).show();
                    }
                }
                // "Password Tidak Cocok" pesan ini akan muncul jika input pada bagian "Password" dan "Konfirmasi Password" berbeda
                else {
                    Toast.makeText(getApplicationContext(), "Password Tidak Cocok", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }
}
