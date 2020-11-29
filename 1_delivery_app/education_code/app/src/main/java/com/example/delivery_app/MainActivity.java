package com.example.delivery_app;

import android.os.Bundle;

import androidx.appcompat.widget.Toolbar;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.delivery_app.Adapter.ListRecyclerAdapter;

public class MainActivity extends AppCompatActivity {

    Toolbar toolbar;
    RecyclerView list_recyclerView;
    RecyclerView reco_recyclerView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        list_recyclerView = findViewById(R.id.list_recycler);
        reco_recyclerView = findViewById(R.id.reco_recycler);

        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(this);
        linearLayoutManager.setOrientation(LinearLayoutManager.HORIZONTAL);

        ListRecyclerAdapter listRecyclerAdapter = new ListRecyclerAdapter();

        list_recyclerView.setAdapter(listRecyclerAdapter);
        list_recyclerView.setLayoutManager(linearLayoutManager);



    }
}