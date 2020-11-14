package com.example.delivery_app.DetailFragment.Adapter;

import android.view.View;
import android.widget.CheckBox;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.delivery_app.R;

public class FoodViewHolder extends RecyclerView.ViewHolder {

    TextView name;
    TextView content;
    TextView price;
    CheckBox check;

    public FoodViewHolder(@NonNull View itemView) {
        super(itemView);

        name = itemView.findViewById(R.id.food_name);
        content = itemView.findViewById(R.id.food_content);
        price = itemView.findViewById(R.id.food_price);
        check = itemView.findViewById(R.id.food_check);

    }
}
