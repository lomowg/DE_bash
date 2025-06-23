#!/bin/bash

LOG_FILE="access.log"
REPORT_FILE="report.txt"

total_requests=$(wc -l < "$LOG_FILE")

unique_ips=$(awk '{print $1}' "$LOG_FILE" | sort | uniq | wc -l)

method_counts=$(awk '{print $6}' "$LOG_FILE" | tr -d '"' | sort | uniq -c)

most_popular_url=$(awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 1)

{
    echo "Отчет о логе веб-сервера"
    echo "========================="
    echo "Общее количество запросов:    $total_requests"
    echo "Количество уникальных IP-адресов: $unique_ips"
    echo
    echo "Количество запросов по методам:"
    echo "$method_counts"
    echo
    echo -n "Самый популярный URL:       "
    echo "$most_popular_url"
} > "$REPORT_FILE"

echo "Отчет сохранен в файл $REPORT_FILE"
