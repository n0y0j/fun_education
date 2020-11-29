package com.example.delivery_app.Adapter;

import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.delivery_app.R;

public class ListViewHolder extends RecyclerView.ViewHolder{

    TextView name;
    ImageView image;

    public ListViewHolder(@NonNull View itemView) {
        super(itemView);

        name = itemView.findViewById(R.id.list_name);
        image = itemView.findViewById(R.id.list_image);
    }
}

