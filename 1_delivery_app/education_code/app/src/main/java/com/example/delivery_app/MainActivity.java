package com.example.delivery_app;

import android.os.Bundle;
import android.os.Handler;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.delivery_app.Adapter.ListRecyclerAdapter;
import com.example.delivery_app.Adapter.RecoRecyclerAdapter;
import com.example.delivery_app.Model.Reco;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.QueryDocumentSnapshot;
import com.google.firebase.firestore.QuerySnapshot;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    Toolbar toolbar;
    RecyclerView list_recyclerView;
    RecyclerView reco_recyclerView;
    FirebaseFirestore db = FirebaseFirestore.getInstance();
    ArrayList<Reco> product = new ArrayList<Reco>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        db.collection("food").get().addOnCompleteListener(new OnCompleteListener<QuerySnapshot>() {
            @Override
            public void onComplete(@NonNull Task<QuerySnapshot> task) {
                if(task.isSuccessful()) {
                    for (QueryDocumentSnapshot document : task.getResult()) {
                        if (document.getData().get("title").toString().equals("Burger")) {
                            String name = document.getData().get("title").toString();
                            String url = document.getData().get("image").toString();
                            String price = document.getData().get("price").toString();
                            product.add(new Reco(name, url, price));
                        }
                    }
                }
            }
        });

        toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        list_recyclerView = findViewById(R.id.list_recycler);
        reco_recyclerView = findViewById(R.id.reco_recycler);

        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(this);
        linearLayoutManager.setOrientation(LinearLayoutManager.HORIZONTAL);

        LinearLayoutManager linearLayoutManager2 = new LinearLayoutManager(getApplicationContext());
        linearLayoutManager2.setOrientation(LinearLayoutManager.HORIZONTAL);

        ListRecyclerAdapter listRecyclerAdapter = new ListRecyclerAdapter();

        list_recyclerView.setAdapter(listRecyclerAdapter);
        list_recyclerView.setLayoutManager(linearLayoutManager);

        // 데이터를 FireStore에서 받아와 HashMap product가 저장할 때 까지의 시간을 지연시킨다.
        final Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                RecoRecyclerAdapter recoRecyclerAdapter = new RecoRecyclerAdapter(product);
                reco_recyclerView.setAdapter(recoRecyclerAdapter);
                reco_recyclerView.setLayoutManager(linearLayoutManager2);
            }
        },1500);
    }
}
