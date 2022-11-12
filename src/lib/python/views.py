from django.shortcuts import render
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.db import IntegrityError
from django.http import HttpResponse, HttpResponseRedirect, JsonResponse
from django.urls import reverse
import json

from .models import *

# def ajax_view(request):
#     if (request.headers.get("x-requested-width") == "XMLHttpRequest"):
#         data = json.loads(request.body.decode("utf-8"))
#         if request.method == "POST":
        
#         content = data['']
#         context = {
#             '': ''
#         }
#         return JsonResponse(context)
#     else:
#         return render(request, "")

# Create your views here.

def index(request):
    return render(request, "default/index.html")

def login_view(request):
    if request.method == "POST":
        # Attempt to sign user in
        username = request.POST["username"]
        password = request.POST["password"]
        user = authenticate(request, username=username, password=password)

        # Check if authentication successful
        if user is not None:
            login(request, user)
            return HttpResponseRedirect(reverse("index"))
        else:
            return render(request, "default/login.html", {
                "message": "Invalid username and/or password."
                })
    else:
        return render(request, "default/login.html")




def register(request):
    if request.method == "POST":
        username = request.POST["username"]
        email = request.POST["email"]

        # Ensure password matches confirmation
        password = request.POST["password"]
        confirmation = request.POST["confirmation"]
        if password != confirmation:
            return render(request, "default/register.html", {
                "message": "Passwords must match."
                })

        # Attempt to create new user
        try:
            user = User.objects.create_user(username, email, password)
            user.save()
        except IntegrityError:
            return render(request, "default/register.html", {
                "message": "Username already taken."
                })
            login(request, user)
        return HttpResponseRedirect(reverse("index"))
    else:
        return render(request, "default/register.html")


@login_required
def logout_view(request):
    logout(request)
    return HttpResponseRedirect(reverse("index"))

@login_required
def profile(request, username):
    user = User.objects.get(username = username)
    return render(request, "default/profile.html")