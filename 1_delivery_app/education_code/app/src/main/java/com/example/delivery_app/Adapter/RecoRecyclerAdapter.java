package com.example.delivery_app.Adapter;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.example.delivery_app.Model.Reco;
import com.example.delivery_app.R;

import java.util.ArrayList;

public class RecoRecyclerAdapter extends RecyclerView.Adapter<RecoViewHolder> {

    private Context context;
    private ArrayList<Reco> product;

    public RecoRecyclerAdapter(ArrayList<Reco> product) {
        this.product = product;
        Log.d("TAG", product.toString());
    }

    @NonNull
    @Override
    public RecoViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        context = parent.getContext();

        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View view = inflater.inflate(R.layout.recommend_food, parent, false);
        RecoViewHolder viewHolder = new RecoViewHolder(view);

        return viewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull RecoViewHolder holder, int position) {
        holder.name.setText(product.get(position).name);
        holder.price.setText(product.get(position).price);

        Glide.with(context).load(product.get(position).url).into(holder.image);

        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(context, holder.name.getText() , Toast.LENGTH_SHORT).show();
            }
        });

    }

    @Override
    public int getItemCount() {
        return product.size();
    }
}
