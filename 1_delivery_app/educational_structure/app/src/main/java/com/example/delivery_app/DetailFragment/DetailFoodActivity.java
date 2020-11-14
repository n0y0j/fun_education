package com.example.delivery_app.DetailFragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.delivery_app.DetailFragment.Adapter.FoodRecyclerAdapter;
import com.example.delivery_app.R;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.QueryDocumentSnapshot;
import com.google.firebase.firestore.QuerySnapshot;

import java.util.ArrayList;
import java.util.HashMap;

public class DetailFoodActivity extends AppCompatActivity {

    private HashMap<String, ArrayList<String>> product = new HashMap<>();
    FirebaseFirestore db = FirebaseFirestore.getInstance();

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_food);

        TextView name = findViewById(R.id.food_name);
        TextView score = findViewById(R.id.food_score);
        TextView min_price = findViewById(R.id.food_min_price);

        Intent intent = getIntent();

        name.setText(intent.getStringExtra("name"));
        score.setText(intent.getStringExtra("score"));
        min_price.setText(intent.getStringExtra("min_price"));

        ArrayList<String> food_name = new ArrayList<String>();
        ArrayList<String> food_content = new ArrayList<String>();
        ArrayList<String> food_price = new ArrayList<String>();

        db.collection("korea_food").document(intent.getStringExtra("name")).collection("menu").get()
                .addOnCompleteListener(new OnCompleteListener<QuerySnapshot>() {
                    @Override
                    public void onComplete(@NonNull Task<QuerySnapshot> task) {
                        if (task.isSuccessful()) {
                            for (QueryDocumentSnapshot document : task.getResult()) {
                                food_name.add(document.getId());
                                food_content.add(document.get("content").toString());
                                food_price.add(document.get("price").toString());
                            }
                        } else {
                            Log.w("zzzzzzz", "Error getting documents.", task.getException());
                        }
                    }
                });

        Handler handler = new Handler();

        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                product.put("name", food_name);
                product.put("content", food_content);
                product.put("price", food_price);

                RecyclerView recyclerView = findViewById(R.id.food_recycler);
                FoodRecyclerAdapter foodRecyclerAdapter = new FoodRecyclerAdapter(product);
                LinearLayoutManager manager = new LinearLayoutManager(getApplicationContext());
                recyclerView.setLayoutManager(manager);
                recyclerView.setAdapter(foodRecyclerAdapter);
            }
        }, 2000);

    }
}
