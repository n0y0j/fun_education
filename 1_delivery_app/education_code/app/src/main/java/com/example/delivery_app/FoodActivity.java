package com.example.delivery_app;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.ImageButton;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.delivery_app.Adapter.FoodRecyclerAdapter;
import com.example.delivery_app.Model.Reco;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.QueryDocumentSnapshot;
import com.google.firebase.firestore.QuerySnapshot;

import java.util.ArrayList;

public class FoodActivity extends AppCompatActivity {

    Toolbar toolbar;
    RecyclerView food_recyclerView;
    ImageButton backBtn;
    FirebaseFirestore db = FirebaseFirestore.getInstance();
    ArrayList<Reco> product = new ArrayList<Reco>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_food);

        Intent intent = getIntent();

        db.collection("food").get().addOnCompleteListener(new OnCompleteListener<QuerySnapshot>() {
            @Override
            public void onComplete(@NonNull Task<QuerySnapshot> task) {
                if(task.isSuccessful()) {
                    for (QueryDocumentSnapshot document : task.getResult()) {
                        if (document.getData().get("title").toString().equals(intent.getStringExtra("name"))) {
                            String name = document.getData().get("title").toString();
                            String url = document.getData().get("image").toString();
                            String price = document.getData().get("price").toString();
                            product.add(new Reco(name, url, price));
                        }
                    }
                }
            }
        });

        toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        backBtn = findViewById(R.id.back_btn);
        backBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        food_recyclerView = findViewById(R.id.food_recycler);

        LinearLayoutManager linearLayoutManager = new GridLayoutManager(this, 2);

        // 데이터를 FireStore에서 받아와 HashMap product가 저장할 때 까지의 시간을 지연시킨다.
        final Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                FoodRecyclerAdapter foodRecyclerAdapter = new FoodRecyclerAdapter(product);
                food_recyclerView.setAdapter(foodRecyclerAdapter);
                food_recyclerView.setLayoutManager(linearLayoutManager);
            }
        },1500);
    }
}

