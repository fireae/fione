/*
 * Copyright 2012-2019 CodeLibs Project and the Others.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 * either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */
package org.codelibs.fione.h2o.bindings.pojos;

import org.codelibs.core.lang.StringUtil;

import com.google.gson.GsonBuilder;
import com.google.gson.annotations.SerializedName;

public class JobV3 extends SchemaV3 {

    /**
     * Job Key
     */
    public JobKeyV3 key;

    /**
     * Job description
     */
    public String description;

    /**
     * job status
     */
    public String status;

    /**
     * progress, from 0 to 1
     */
    public float progress;

    /**
     * current progress status description
     */
    @SerializedName("progress_msg")
    public String progressMsg;

    /**
     * Start time
     */
    @SerializedName("start_time")
    public long startTime;

    /**
     * Runtime in milliseconds
     */
    public long msec;

    /**
     * destination key
     */
    public KeyV3 dest;

    /**
     * exception
     */
    public String[] warnings;

    /**
     * exception
     */
    public String exception;

    /**
     * stacktrace
     */
    public String stacktrace;

    /**
     * ready for view
     */
    @SerializedName("ready_for_view")
    public boolean readyForView;

    /**
     * Public constructor
     */
    public JobV3() {
        description = "";
        status = "";
        progress = 0.0f;
        progressMsg = "";
        startTime = 0L;
        msec = 0L;
        exception = "";
        stacktrace = "";
        readyForView = false;
    }

    /**
     * Return the contents of this object as a JSON String.
     */
    @Override
    public String toString() {
        return new GsonBuilder().serializeSpecialFloatingPointValues().create().toJson(this);
    }

    public String getIconType() {
        switch (getKind()) {
        case MODEL:
        case AUTO_ML:
            return "hammer";
        case FRAME:
            return "table";
        case GRID:
            return "th";
        default:
            return "question";
        }
    }

    public Kind getKind() {
        if (StringUtil.isBlank(description)) {
            return Kind.UNKNOWN;
        } else if (description.indexOf("AutoML build") >= 0) {
            return Kind.AUTO_ML;
        } else if (description.indexOf("Parse") >= 0) {
            return Kind.FRAME;
        } else if (description.indexOf("Grid Search") >= 0) {
            return Kind.GRID;
        }
        return Kind.MODEL;
    }

    public enum Kind {
        FRAME, MODEL, AUTO_ML, GRID, UNKNOWN;
    }
}
