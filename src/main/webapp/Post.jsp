<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<div class="w3-container w3-padding-24 w3-white">
    <h3 class="w3-text-theme">✍️ Share a Recipe</h3>
    
    <form class="w3-container" style="max-width: 600px; margin-top: 20px;">
        
        <label class="w3-text-theme" style="font-weight: bold;">Recipe Title</label>
        <input class="w3-input w3-border" type="text" placeholder="e.g., Italian Pasta Carbonara" style="margin-bottom: 16px;">
        
        <label class="w3-text-theme" style="font-weight: bold;">Brief description</label>
        <textarea class="w3-input w3-border" rows="4" placeholder="Tell us about your recipe..." style="margin-bottom: 16px; font-family: Arial, sans-serif;"></textarea>
        
        <label class="w3-text-theme" style="font-weight: bold;">Ingredients</label>
        <textarea class="w3-input w3-border" rows="6" placeholder="List ingredients (one per line)&#10;e.g.:&#10;- 400g pasta&#10;- 200g bacon&#10;- 3 eggs" style="margin-bottom: 16px; font-family: Arial, sans-serif;"></textarea>
        
        <label class="w3-text-theme" style="font-weight: bold;">Instructions</label>
        <textarea class="w3-input w3-border" rows="6" placeholder="Step-by-step instructions..." style="margin-bottom: 16px; font-family: Arial, sans-serif;"></textarea>
        
        <label class="w3-text-theme" style="font-weight: bold;">Upload Image</label>
        <input class="w3-input w3-border" type="file" accept="image/*" style="margin-bottom: 16px;">
        
        <label class="w3-text-theme" style="font-weight: bold;">Cooking Time (minutes)</label>
        <input class="w3-input w3-border" type="number" placeholder="e.g., 30" style="margin-bottom: 16px;">
        
        <label class="w3-text-theme" style="font-weight: bold;">Difficulty Level</label>
        <select class="w3-select w3-border" style="margin-bottom: 16px;">
            <option selected>Choose difficulty...</option>
            <option>Easy</option>
            <option>Medium</option>
            <option>Hard</option>
        </select>


        <div style="display: flex; gap: 10px;">
            <button type="submit" class="w3-button w3-theme" style="padding: 10px 20px;">📤 Publish Recipe</button>
            <button type="reset" class="w3-button w3-light-grey" style="padding: 10px 20px;">Clear</button>
            <a href="/index.html" class="w3-button w3-white w3-border" style="padding: 10px 20px; text-decoration: none;">Cancel</a>
        </div>
    </form>
</div>
