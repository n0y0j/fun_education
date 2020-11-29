package com.example.delivery_app.Adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.delivery_app.R;

public class ListRecyclerAdapter extends RecyclerView.Adapter<ListViewHolder> {

    private int[] icon = {
            R.drawable.chicken, R.drawable.burger, R.drawable.pizza, R.drawable.bevarage
    };
    private String[] name = {
            "Chicken", "Burger", "Pizza", "Bevarage"
    };

    private Context context;

    @NonNull
    @Override
    public ListViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        context = parent.getContext();

        LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View view = inflater.inflate(R.layout.food_list_card, parent, false);
        ListViewHolder viewHolder = new ListViewHolder(view);

        return viewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull ListViewHolder holder, int position) {
        holder.name.setText(name[position]);
        holder.image.setImageResource(icon[position]);

        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(context, holder.name.getText() , Toast.LENGTH_SHORT).show();
            }
        });

    }

    @Override
    public int getItemCount() {
        return icon.length;
    }
}
