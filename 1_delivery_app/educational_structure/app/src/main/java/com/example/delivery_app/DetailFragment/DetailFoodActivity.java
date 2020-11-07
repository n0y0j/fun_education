package com.example.delivery_app.DetailFragment;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.example.delivery_app.R;

public class DetailFoodActivity extends AppCompatActivity {
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

    }
}
