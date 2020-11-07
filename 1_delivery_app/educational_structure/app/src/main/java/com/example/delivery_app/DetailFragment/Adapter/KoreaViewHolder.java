package com.example.delivery_app.DetailFragment.Adapter;

import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.delivery_app.R;

public class KoreaViewHolder extends RecyclerView.ViewHolder {

    ImageView image;
    TextView name;
    TextView score;
    TextView min_price;

    public KoreaViewHolder(@NonNull View itemView) {
        super(itemView);

        image = itemView.findViewById(R.id.korea_image);
        name = itemView.findViewById(R.id.korea_name);
        score = itemView.findViewById(R.id.korea_score);
        min_price = itemView.findViewById(R.id.korea_min_price);

    }
}
