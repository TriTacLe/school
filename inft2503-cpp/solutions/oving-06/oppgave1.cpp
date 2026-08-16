// Oving 6 oppgave 1: move all printing out of ChessBoard into a separate
// ChessBoardPrint class. ChessBoard exposes std::function callbacks; the
// print class fills them with lambdas in its constructor, and uses the
// after_piece_move callback to redraw the board after each move.
#include <cmath>
#include <functional>
#include <iostream>
#include <memory>
#include <string>
#include <vector>

using namespace std;

class ChessBoard {
public:
    enum class Color { WHITE, BLACK };

    class Piece {
    public:
        Piece(Color color) : color(color) {}
        virtual ~Piece() {}
        Color color;
        string color_string() const { return color == Color::WHITE ? "white" : "black"; }
        virtual string type() const = 0;
        virtual char symbol() const = 0;  // one letter, used by the print class
        virtual bool valid_move(int from_x, int from_y, int to_x, int to_y) const = 0;
    };

    class King : public Piece {
    public:
        King(Color color) : Piece(color) {}
        string type() const override { return color_string() + " king"; }
        char symbol() const override { return 'K'; }
        bool valid_move(int from_x, int from_y, int to_x, int to_y) const override {
            int dx = abs(to_x - from_x), dy = abs(to_y - from_y);
            return (dx <= 1 && dy <= 1) && (dx != 0 || dy != 0);
        }
    };

    class Knight : public Piece {
    public:
        Knight(Color color) : Piece(color) {}
        string type() const override { return color_string() + " knight"; }
        char symbol() const override { return 'N'; }
        bool valid_move(int from_x, int from_y, int to_x, int to_y) const override {
            int dx = abs(to_x - from_x), dy = abs(to_y - from_y);
            return (dx == 1 && dy == 2) || (dx == 2 && dy == 1);
        }
    };

    ChessBoard() {
        squares.resize(8);
        for (auto &column : squares)
            column.resize(8);
    }

    vector<vector<unique_ptr<Piece>>> squares;

    // function objects, filled in from outside (ChessBoardPrint)
    function<void(const string &type, const string &from, const string &to)> on_move;
    function<void(const string &type, const string &to)> on_capture;
    function<void(const string &color)> on_game_lost;
    function<void(const string &message)> on_invalid;
    function<void()> after_piece_move;

    bool move_piece(const string &from, const string &to) {
        int from_x = from[0] - 'a';
        int from_y = stoi(string() + from[1]) - 1;
        int to_x = to[0] - 'a';
        int to_y = stoi(string() + to[1]) - 1;
        auto &piece_from = squares[from_x][from_y];
        if (!piece_from) {
            if (on_invalid)
                on_invalid("no piece at " + from);
            return false;
        }
        if (!piece_from->valid_move(from_x, from_y, to_x, to_y)) {
            if (on_invalid)
                on_invalid("can not move " + piece_from->type() + " from " + from + " to " + to);
            return false;
        }
        if (on_move)
            on_move(piece_from->type(), from, to);
        auto &piece_to = squares[to_x][to_y];
        if (piece_to) {
            if (piece_from->color == piece_to->color) {
                if (on_invalid)
                    on_invalid("can not move " + piece_from->type() + " from " + from + " to " + to);
                return false;
            }
            if (on_capture)
                on_capture(piece_to->type(), to);
            if (dynamic_cast<King *>(piece_to.get()) && on_game_lost)
                on_game_lost(piece_to->color_string());
        }
        piece_to = std::move(piece_from);
        if (after_piece_move)
            after_piece_move();
        return true;
    }
};

class ChessBoardPrint {
public:
    ChessBoardPrint(ChessBoard &board) : board(board) {
        board.on_move = [](const string &type, const string &from, const string &to) {
            cout << type << " is moving from " << from << " to " << to << endl;
        };
        board.on_capture = [](const string &type, const string &to) {
            cout << type << " is being removed from " << to << endl;
        };
        board.on_game_lost = [](const string &color) {
            cout << color << " lost the game" << endl;
        };
        board.on_invalid = [](const string &message) { cout << message << endl; };
        board.after_piece_move = [this]() { print_board(); };
    }

    void print_board() const {
        for (int y = 7; y >= 0; --y) {
            for (int x = 0; x < 8; ++x) {
                auto &piece = board.squares[x][y];
                if (!piece) {
                    cout << ". ";
                } else {
                    char c = piece->symbol();
                    if (piece->color == ChessBoard::Color::BLACK)
                        c = tolower(c);
                    cout << c << " ";
                }
            }
            cout << endl;
        }
        cout << endl;
    }

private:
    ChessBoard &board;
};

int main() {
    ChessBoard board;
    ChessBoardPrint print(board);
    board.squares[4][0] = make_unique<ChessBoard::King>(ChessBoard::Color::WHITE);
    board.squares[1][0] = make_unique<ChessBoard::Knight>(ChessBoard::Color::WHITE);
    board.squares[6][0] = make_unique<ChessBoard::Knight>(ChessBoard::Color::WHITE);
    board.squares[4][7] = make_unique<ChessBoard::King>(ChessBoard::Color::BLACK);
    board.squares[1][7] = make_unique<ChessBoard::Knight>(ChessBoard::Color::BLACK);
    board.squares[6][7] = make_unique<ChessBoard::Knight>(ChessBoard::Color::BLACK);

    cout << "Start:" << endl;
    print.print_board();

    cout << "A simulated game:" << endl;
    board.move_piece("e1", "e2");
    board.move_piece("g8", "h6");
    board.move_piece("b1", "c3");
    board.move_piece("h6", "g8");
    board.move_piece("c3", "d5");
    board.move_piece("g8", "h6");
    board.move_piece("d5", "f6");
    board.move_piece("h6", "g8");
    board.move_piece("f6", "e8");
    return 0;
}
