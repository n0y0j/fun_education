package com.example.delivery_app;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentStatePagerAdapter;

import com.example.delivery_app.DetailFragment.ChinaFragment;
import com.example.delivery_app.DetailFragment.JapanFragment;
import com.example.delivery_app.DetailFragment.KoreaFragment;

public class DetailPagerAdapter extends FragmentStatePagerAdapter {

    private int pageCount;

    public DetailPagerAdapter(@NonNull FragmentManager fm, int behavior) {
        super(fm, behavior);
        pageCount = behavior;
    }

    @NonNull
    @Override
    public Fragment getItem(int position) {
        switch (position) {
            case 0:
                KoreaFragment koreaFragment = new KoreaFragment();
                return koreaFragment;
            case 1:
                JapanFragment japanFragment = new JapanFragment();
                return japanFragment;
            case 2:
                ChinaFragment chinaFragment = new ChinaFragment();
                return chinaFragment;
            default:
                return null;
        }
    }

    @Override
    public int getCount() {
        return pageCount;
    }
}
