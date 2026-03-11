package com.clearshift.event.service;

import com.clearshift.event.entity.CalendarEvent;
import com.clearshift.event.repository.EventRepository;
import com.clearshift.user.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class EventService {

    private final EventRepository eventRepository;

    public List<CalendarEvent> getEvents(User manager) {
        return eventRepository.findByBranchIdOrderByStartDateAsc(manager.getBranch().getId());
    }

    public List<CalendarEvent> searchEvents(User manager, String keyword) {
        return eventRepository.findByBranchIdAndTitleContainingIgnoreCaseOrderByStartDateAsc(
            manager.getBranch().getId(), keyword);
    }

    @Transactional
    public CalendarEvent create(User manager, CalendarEvent event) {
        event.setBranch(manager.getBranch());
        return eventRepository.save(event);
    }

    @Transactional
    public CalendarEvent update(User user, UUID id, CalendarEvent updated) {
        CalendarEvent existing = eventRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        verifyBranchOwnership(existing, user);

        existing.setTitle(updated.getTitle());
        existing.setStartDate(updated.getStartDate());
        existing.setEndDate(updated.getEndDate());
        existing.setColor(updated.getColor());
        existing.setMemo(updated.getMemo());
        return eventRepository.save(existing);
    }

    @Transactional
    public void delete(User user, UUID id) {
        CalendarEvent existing = eventRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        verifyBranchOwnership(existing, user);

        eventRepository.deleteById(id);
    }

    private void verifyBranchOwnership(CalendarEvent event, User user) {
        if (!event.getBranch().getId().equals(user.getBranch().getId())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Access denied: event belongs to another branch");
        }
    }
}
