package com.edupath.dto;

public class NotificationDto {

    private final String title;
    private final String message;
    private final String timeLabel;
    private final boolean unread;

    public NotificationDto(String title, String message, String timeLabel, boolean unread) {
        this.title = title;
        this.message = message;
        this.timeLabel = timeLabel;
        this.unread = unread;
    }

    public String getTitle() {
        return title;
    }

    public String getMessage() {
        return message;
    }

    public String getTimeLabel() {
        return timeLabel;
    }

    public boolean isUnread() {
        return unread;
    }
}
