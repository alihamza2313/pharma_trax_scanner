import 'package:flutter/material.dart';

class AII
{
    String? title;
    String? content;
    int? minimumLength;
    int? maximumLength;
    bool? requiredFNC1;

    AII(String title, String content, int minimumLength, int maximumLength, bool requiredFNC1)
    {
        this.title = title;
        this.content = content;
        this.minimumLength = minimumLength;
        this.maximumLength = maximumLength;
        this.requiredFNC1 = requiredFNC1;
    }

    String getTitle()
    {
        return title!;
    }

    void setTitle(String title)
    {
        this.title = title;
    }

    String getContent()
    {
        return content!;
    }

    void setContent(String content)
    {
        this.content = content;
    }

    int getMinimumLength()
    {
        return minimumLength!;
    }

    void setMinimumLength(int minimumLength)
    {
        this.minimumLength = minimumLength;
    }

    int getMaximumLength()
    {
        return maximumLength!;
    }

    void setMaximumLength(int maximumLength)
    {
        this.maximumLength = maximumLength;
    }

    bool isRequiredFNC1()
    {
        return requiredFNC1!;
    }

    void setRequiredFNC1(bool requiredFNC1)
    {
        this.requiredFNC1 = requiredFNC1;
    }

    String getDate()
    {
        String date;
        List<String> months =  List<String>.from(["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]);
        try {
            String year = ("20" + content!.substring(0, 2));
            String month = months[int.parse(content!.substring(2, 4)) - 1];
            String day = content!.substring(4);
            if (int.parse(content!.substring(4)) == 0) {
                date = ((month + " ") + year);
            } else {
                date = ((((day + " ") + month) + ", ") + year);
            }
        } on Exception catch (ex) {
            date = content!;
        }
        return date;
    }
}