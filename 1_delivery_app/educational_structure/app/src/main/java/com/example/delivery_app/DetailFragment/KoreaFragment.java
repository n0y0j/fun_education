package com.example.delivery_app.DetailFragment;

import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.delivery_app.DetailFragment.Adapter.KoreaRecyclerAdapter;
import com.example.delivery_app.R;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.QueryDocumentSnapshot;
import com.google.firebase.firestore.QuerySnapshot;

import java.util.ArrayList;
import java.util.HashMap;

public class KoreaFragment extends Fragment {

    private HashMap<String, ArrayList<String>> product = new HashMap<>();
    FirebaseFirestore db = FirebaseFirestore.getInstance();

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_korea, container, false);

        ArrayList<String> name = new ArrayList<String>();
        ArrayList<String> score = new ArrayList<String>();
        ArrayList<String> min_price = new ArrayList<String>();

        db.collection("korea_food")
                .get()
                .addOnCompleteListener(new OnCompleteListener<QuerySnapshot>() {
                    @Override
                    public void onComplete(@NonNull Task<QuerySnapshot> task) {
                        if (task.isSuccessful()) {
                            for (QueryDocumentSnapshot document : task.getResult()) {
                                name.add(document.getId());
                                score.add(document.get("score").toString());
                                min_price.add(document.get("min_price").toString());
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
                product.put("name", name);
                product.put("score", score);
                product.put("min_price", min_price);

                RecyclerView recyclerView = view.findViewById(R.id.korea_recycler);
                KoreaRecyclerAdapter koreaRecyclerAdapter = new KoreaRecyclerAdapter(product);
                LinearLayoutManager manager = new LinearLayoutManager(getActivity());
                recyclerView.setLayoutManager(manager);
                recyclerView.setAdapter(koreaRecyclerAdapter);
            }
        }, 2000);

        return view;
    }
}