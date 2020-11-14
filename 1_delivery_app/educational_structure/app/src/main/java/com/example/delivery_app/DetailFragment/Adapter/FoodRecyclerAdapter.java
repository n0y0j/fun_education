package com.example.delivery_app.DetailFragment.Adapter;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.delivery_app.R;

import java.util.ArrayList;
import java.util.HashMap;

public class FoodRecyclerAdapter extends RecyclerView.Adapter<FoodViewHolder> {

    private HashMap<String, ArrayList<String>> product = new HashMap<>();
    Context context;

    public FoodRecyclerAdapter(HashMap<String, ArrayList<String>> product) {
        this.product = product;
        Log.d("zzzzzzzzzzz", this.product.toString());
    }

    @NonNull
    @Override
    public FoodViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        context = parent.getContext();

        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        View view = inflater.inflate(R.layout.menu_item_card, parent, false);
        FoodViewHolder viewHolder = new FoodViewHolder(view);

        return viewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull FoodViewHolder holder, int position) {
        holder.name.setText(product.get("name").get(position));
        holder.content.setText(product.get("content").get(position));
        holder.price.setText(product.get("price").get(position));

    }

    @Override
    public int getItemCount() {
        return product.get("name").size();
    }
}
