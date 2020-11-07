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

public class KoreaRecyclerAdapter extends RecyclerView.Adapter<KoreaViewHolder> {

    private HashMap<String, ArrayList<String>> product = new HashMap<>();

    private int[] src = {
            R.drawable.kimbap, R.drawable.kimchi, R.drawable.rice
    };

    public KoreaRecyclerAdapter(HashMap<String, ArrayList<String>> product) {
        this.product = product;
        Log.d("zzzzzzzzzzz", this.product.toString());
    }

    @NonNull
    @Override
    public KoreaViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        Context context = parent.getContext();

        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

        View view = inflater.inflate(R.layout.detail_item_card, parent, false);
        KoreaViewHolder viewHolder = new KoreaViewHolder(view);

        return viewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull KoreaViewHolder holder, int position) {
        Log.d("zzzzzzzzzzz", product.get("name").get(position));

        holder.image.setImageResource(src[position]);
        holder.name.setText(product.get("name").get(position));
        holder.score.setText(product.get("score").get(position));
        holder.min_price.setText(product.get("min_price").get(position));

    }

    @Override
    public int getItemCount() {
        return product.get("name").size();
    }
}
