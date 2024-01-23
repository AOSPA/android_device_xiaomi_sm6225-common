/*
 * Copyright (C) 2019 The Android Open Source Project
 *           (C) 2023 Paranoid Android
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License
 */

package org.lineageos.settings;

import static com.android.settingslib.drawer.TileUtils.META_DATA_PREFERENCE_SUMMARY;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.database.Cursor;
import android.net.Uri;
import android.os.Bundle;

import org.lineageos.settings.R;
import org.lineageos.settings.gestures.GestureUtils;

import java.util.Arrays;
import java.util.List;

/** Provide preference summary for injected items. */
public class SummaryProvider extends ContentProvider {

    private static final String KEY_FP_DOUBLE_TAP = "fp_double_tap";

    @Override
    public Bundle call(String method, String uri, Bundle extras) {
        final Bundle bundle = new Bundle();
        String summary;
        switch (method) {
            case KEY_FP_DOUBLE_TAP:
                summary = getFpDoubleTapSummary();
                break;
            default:
                throw new IllegalArgumentException("Unknown method: " + method);
        }
        bundle.putString(META_DATA_PREFERENCE_SUMMARY, summary);
        return bundle;
    }

    @Override
    public boolean onCreate() {
        return true;
    }

    @Override
    public Cursor query(Uri uri, String[] projection, String selection, String[] selectionArgs,
            String sortOrder) {
        throw new UnsupportedOperationException();
    }

    @Override
    public String getType(Uri uri) {
        throw new UnsupportedOperationException();
    }

    @Override
    public Uri insert(Uri uri, ContentValues values) {
        throw new UnsupportedOperationException();
    }

    @Override
    public int delete(Uri uri, String selection, String[] selectionArgs) {
        throw new UnsupportedOperationException();
    }

    @Override
    public int update(Uri uri, ContentValues values, String selection, String[] selectionArgs) {
        throw new UnsupportedOperationException();
    }

    private String getFpDoubleTapSummary() {
        if (!GestureUtils.isFpDoubleTapEnabled(getContext())) {
            return getContext().getString(R.string.fp_double_tap_summary_off);
        }
        final int action = GestureUtils.getFpDoubleTapAction(getContext());
        final List<String> actions = Arrays.asList(getContext().getResources().getStringArray(
                R.array.fp_double_tap_action_values));
        final int actionIndex = actions.indexOf(Integer.toString(action));
        final String actionName = getContext().getResources().getStringArray(
                R.array.fp_double_tap_action_entries)[actionIndex];
        return getContext().getString(R.string.fp_double_tap_summary_on, actionName);
    }

}
