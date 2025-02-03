<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\Auth;

class ChatController extends Controller
{
    public function sendMessage(Request $request)
    {
        $request->validate([
            'message' => 'required|string',
        ]);

        $user = Auth::user();
        $message = $request->message;

        broadcast(new MessageSent($user, $message))->toOthers();

        return response()->json(['status' => 'Message sent']);
    }
}
