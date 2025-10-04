import mysql.connector
import tkinter as tk
from tkinter import messagebox
from tkinter import ttk
from datetime import datetime

def connect_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Kdot15Curry30!!",
        database="LinkedInResults"
    )


class LinkedInApp:
    def __init__(self, root):
        self.root = root
        self.root.title("LinkedIn Database App")
        self.conn = connect_db()
        self.cursor = self.conn.cursor()

        tab_control = ttk.Notebook(root)

        self.user_tab = ttk.Frame(tab_control)
        self.post_tab = ttk.Frame(tab_control)
        self.comment_tab = ttk.Frame(tab_control)
        self.experience_tab = ttk.Frame(tab_control)

        tab_control.add(self.user_tab, text='Users')
        tab_control.add(self.post_tab, text='Posts')
        tab_control.add(self.comment_tab, text='Comments')
        tab_control.add(self.experience_tab, text='Experience')
        tab_control.pack(expand=1, fill='both')

        self.create_user_tab()
        self.create_post_tab()
        self.create_comment_tab()
        self.create_experience_tab()

    def create_user_tab(self):
        labels = ["User ID", "Role", "First Name", "Middle Name", "Last Name", "DOB (YYYY-MM-DD)"]
        self.user_entries = {}
        for i, label in enumerate(labels):
            tk.Label(self.user_tab, text=label).grid(row=i, column=0)
            entry = tk.Entry(self.user_tab)
            entry.grid(row=i, column=1)
            self.user_entries[label] = entry

        tk.Button(self.user_tab, text="Create User", command=self.create_user).grid(row=6, column=0, columnspan=2, pady=10)
        tk.Button(self.user_tab, text="Read All Users", command=self.read_users).grid(row=7, column=0, columnspan=2, pady=5)
        tk.Button(self.user_tab, text="Update User", command=self.update_user).grid(row=8, column=0, columnspan=2, pady=5)
        tk.Button(self.user_tab, text="Delete User", command=self.delete_user).grid(row=9, column=0, columnspan=2, pady=5)
        tk.Button(self.user_tab, text="Search User (any field)", command=self.search_user).grid(row=10, column=0, columnspan=2, pady=5)

        self.user_output = tk.Text(self.user_tab, height=10, width=60)
        self.user_output.grid(row=11, column=0, columnspan=2, pady=10)

    def create_user(self):
        try:
            sql = "INSERT INTO LinkedInUser (UserID, CurrentRole, FirstName, MiddleName, LastName, DateOfBirth) VALUES (%s, %s, %s, %s, %s, %s)"
            values = tuple(entry.get() or None for entry in self.user_entries.values())
            values = (int(values[0]),) + values[1:]  # UserID must be int
            self.cursor.execute(sql, values)
            self.conn.commit()
            messagebox.showinfo("Success", "User created.")
        except Exception as err:
            messagebox.showerror("Error", f"User not created: {err}")

    def read_users(self):
        try:
            self.cursor.execute("SELECT * FROM LinkedInUser")
            rows = self.cursor.fetchall()
            self.user_output.delete(1.0, tk.END)
            for row in rows:
                self.user_output.insert(tk.END, f"{row}\n")
        except Exception as err:
            messagebox.showerror("Error", f"Failed to read users: {err}")

    def update_user(self):
        try:
            user_id = int(self.user_entries["User ID"].get())
            role = self.user_entries["Role"].get()
            self.cursor.execute("UPDATE LinkedInUser SET CurrentRole = %s WHERE UserID = %s", (role, user_id))
            self.conn.commit()
            messagebox.showinfo("Success", "User updated.")
        except Exception as err:
            messagebox.showerror("Error", f"Failed to update user: {err}")

    def delete_user(self):
        try:
            user_id = int(self.user_entries["User ID"].get())
            self.cursor.execute("DELETE FROM LinkedInUser WHERE UserID = %s", (user_id,))
            self.conn.commit()
            messagebox.showinfo("Success", "User deleted.")
        except Exception as err:
            messagebox.showerror("Error", f"Failed to delete user: {err}")

    def search_user(self):
        try:
            query = "SELECT * FROM LinkedInUser WHERE 1=1"
            values = []
            mapping = {
                "User ID": "UserID",
                "Role": "CurrentRole",
                "First Name": "FirstName",
                "Middle Name": "MiddleName",
                "Last Name": "LastName",
                "DOB (YYYY-MM-DD)": "DateOfBirth"
            }

            for label, column in mapping.items():
                val = self.user_entries[label].get().strip()
                if val:
                    query += f" AND {column} LIKE %s"
                    values.append(f"%{val}%")

            self.cursor.execute(query, tuple(values))
            results = self.cursor.fetchall()
            self.user_output.delete(1.0, tk.END)
            if not results:
                self.user_output.insert(tk.END, "No users found.\n")
            else:
                for row in results:
                    self.user_output.insert(tk.END, f"{row}\n")
        except Exception as err:
            messagebox.showerror("Error", f"Search failed: {err}")

    def create_post_tab(self):
        labels = ["Post ID", "User ID", "Image URL", "Caption"]
        self.post_entries = {}
        for i, label in enumerate(labels):
            tk.Label(self.post_tab, text=label).grid(row=i, column=0)
            entry = tk.Entry(self.post_tab)
            entry.grid(row=i, column=1)
            self.post_entries[label] = entry

        tk.Button(self.post_tab, text="Create Post", command=self.create_post).grid(row=4, column=0, columnspan=2, pady=5)
        tk.Button(self.post_tab, text="Read All Posts", command=self.read_posts).grid(row=5, column=0, columnspan=2, pady=5)
        tk.Button(self.post_tab, text="Update Post", command=self.update_post).grid(row=6, column=0, columnspan=2, pady=5)
        tk.Button(self.post_tab, text="Delete Post", command=self.delete_post).grid(row=7, column=0, columnspan=2, pady=5)
        tk.Button(self.post_tab, text="Search Post (any field)", command=self.search_post).grid(row=8, column=0, columnspan=2, pady=5)

        self.post_output = tk.Text(self.post_tab, height=10, width=60)
        self.post_output.grid(row=9, column=0, columnspan=2, pady=10)

    def create_post(self):
        try:
            post_id = int(self.post_entries["Post ID"].get())
            user_id = int(self.post_entries["User ID"].get())
            post_time = datetime.now()
            image = self.post_entries["Image URL"].get()
            caption = self.post_entries["Caption"].get()
            self.cursor.execute(
                "INSERT INTO Post (PostID, UserID, CompanyID, PostTime, Image, Caption) VALUES (%s, %s, NULL, %s, %s, %s)",
                (post_id, user_id, post_time, image, caption)
            )
            self.conn.commit()
            messagebox.showinfo("Success", "Post created.")
        except Exception as err:
            messagebox.showerror("Error", f"Failed to create post: {err}")

    def read_posts(self):
        try:
            self.cursor.execute("SELECT * FROM Post")
            posts = self.cursor.fetchall()
            self.post_output.delete("1.0", tk.END)
            for post in posts:
                self.post_output.insert(tk.END, f"{post}\n")
        except Exception as err:
            messagebox.showerror("Error", f"Failed to read posts: {err}")

    def update_post(self):
        try:
            post_id = int(self.post_entries["Post ID"].get())
            caption = self.post_entries["Caption"].get()
            self.cursor.execute("UPDATE Post SET Caption = %s WHERE PostID = %s", (caption, post_id))
            self.conn.commit()
            messagebox.showinfo("Success", "Post updated.")
        except Exception as err:
            messagebox.showerror("Error", f"Failed to update post: {err}")

    def delete_post(self):
        try:
            post_id = int(self.post_entries["Post ID"].get())
            self.cursor.execute("DELETE FROM Post WHERE PostID = %s", (post_id,))
            self.conn.commit()
            messagebox.showinfo("Success", "Post deleted.")
        except Exception as err:
            messagebox.showerror("Error", f"Failed to delete post: {err}")

    def search_post(self):
        try:
            query = "SELECT * FROM Post WHERE 1=1"
            values = []
            mapping = {
                "Post ID": "PostID",
                "User ID": "UserID",
                "Image URL": "Image",
                "Caption": "Caption"
            }

            for label, column in mapping.items():
                val = self.post_entries[label].get().strip()
                if val:
                    query += f" AND {column} LIKE %s"
                    values.append(f"%{val}%")

            self.cursor.execute(query, tuple(values))
            results = self.cursor.fetchall()
            self.post_output.delete(1.0, tk.END)
            if not results:
                self.post_output.insert(tk.END, "No posts found.\n")
            else:
                for row in results:
                    self.post_output.insert(tk.END, f"{row}\n")
        except Exception as err:
            messagebox.showerror("Error", f"Search failed: {err}")

    def create_comment_tab(self):
        labels = ["Post ID", "Comment Text"]
        self.comment_entries = {}
        for i, label in enumerate(labels):
            tk.Label(self.comment_tab, text=label).grid(row=i, column=0)
            entry = tk.Entry(self.comment_tab)
            entry.grid(row=i, column=1)
            self.comment_entries[label] = entry

        tk.Button(self.comment_tab, text="Add Comment", command=self.add_comment).grid(row=2, column=0, columnspan=2, pady=5)
        tk.Button(self.comment_tab, text="Read Comments for Post", command=self.read_comments_for_post).grid(row=3, column=0, columnspan=2, pady=5)
        tk.Button(self.comment_tab, text="Delete Comment", command=self.delete_comment).grid(row=4, column=0, columnspan=2, pady=5)
        tk.Button(self.comment_tab, text="Search Comments (any field)", command=self.search_comment).grid(row=5, column=0, columnspan=2, pady=5)

        self.comment_output = tk.Text(self.comment_tab, height=10, width=60)
        self.comment_output.grid(row=6, column=0, columnspan=2, pady=10)

    def add_comment(self):
        try:
            post_id = int(self.comment_entries["Post ID"].get())
            text = self.comment_entries["Comment Text"].get()
            post_time = datetime.now()
            self.cursor.execute("INSERT INTO Comment (PostID, Text, PostTime) VALUES (%s, %s, %s)", (post_id, text, post_time))
            self.conn.commit()
            messagebox.showinfo("Success", "Comment added.")
        except Exception as err:
            messagebox.showerror("Error", f"Failed to add comment: {err}")

    def read_comments_for_post(self):
        try:
            post_id = int(self.comment_entries["Post ID"].get())
            self.cursor.execute("SELECT Text, PostTime FROM Comment WHERE PostID = %s", (post_id,))
            comments = self.cursor.fetchall()
            self.comment_output.delete(1.0, tk.END)
            for text, time in comments:
                self.comment_output.insert(tk.END, f"{text} ({time})\n")
        except Exception as err:
            messagebox.showerror("Error", f"Failed to read comments: {err}")

    def delete_comment(self):
        try:
            post_id = int(self.comment_entries["Post ID"].get())
            text = self.comment_entries["Comment Text"].get()
            self.cursor.execute("DELETE FROM Comment WHERE PostID = %s AND Text = %s", (post_id, text))
            self.conn.commit()
            messagebox.showinfo("Success", "Comment deleted.")
        except Exception as err:
            messagebox.showerror("Error", f"Failed to delete comment: {err}")

    def search_comment(self):
        try:
            query = "SELECT * FROM Comment WHERE 1=1"
            values = []
            mapping = {
                "Post ID": "PostID",
                "Comment Text": "Text"
            }
            for label, column in mapping.items():
                val = self.comment_entries[label].get().strip()
                if val:
                    query += f" AND {column} LIKE %s"
                    values.append(f"%{val}%")

            self.cursor.execute(query, tuple(values))
            results = self.cursor.fetchall()
            self.comment_output.delete(1.0, tk.END)
            if not results:
                self.comment_output.insert(tk.END, "No comments found.\n")
            else:
                for row in results:
                    self.comment_output.insert(tk.END, f"{row}\n")
        except Exception as err:
            messagebox.showerror("Error", f"Search failed: {err}")

    def create_experience_tab(self):
        labels = ["User ID", "Role", "Company", "Start Date (YYYY-MM-DD)", "End Date (YYYY-MM-DD)"]
        self.exp_entries = {}
        for i, label in enumerate(labels):
            tk.Label(self.experience_tab, text=label).grid(row=i, column=0)
            entry = tk.Entry(self.experience_tab)
            entry.grid(row=i, column=1)
            self.exp_entries[label] = entry

        tk.Button(self.experience_tab, text="Add Experience", command=self.add_experience).grid(row=5, column=0, columnspan=2, pady=5)
        tk.Button(self.experience_tab, text="Read Experiences for User", command=self.read_experiences).grid(row=6, column=0, columnspan=2, pady=5)
        tk.Button(self.experience_tab, text="Delete Experience", command=self.delete_experience).grid(row=7, column=0, columnspan=2, pady=5)
        tk.Button(self.experience_tab, text="Search Experience (any field)", command=self.search_experience).grid(row=8, column=0, columnspan=2, pady=5)

        self.exp_output = tk.Text(self.experience_tab, height=10, width=60)
        self.exp_output.grid(row=9, column=0, columnspan=2, pady=10)

    def add_experience(self):
        try:
            sql = "INSERT INTO Experience (UserID, Role, Company, StartDate, EndDate) VALUES (%s, %s, %s, %s, %s)"
            values = tuple(entry.get() for entry in self.exp_entries.values())
            values = (int(values[0]),) + values[1:]
            self.cursor.execute(sql, values)
            self.conn.commit()
            messagebox.showinfo("Success", "Experience added.")
        except Exception as err:
            messagebox.showerror("Error", f"Experience not added: {err}")

    def read_experiences(self):
        try:
            user_id = int(self.exp_entries["User ID"].get())
            self.cursor.execute("SELECT Role, Company, StartDate, EndDate FROM Experience WHERE UserID = %s", (user_id,))
            rows = self.cursor.fetchall()
            self.exp_output.delete(1.0, tk.END)
            for row in rows:
                self.exp_output.insert(tk.END, f"{row}\n")
        except Exception as err:
            messagebox.showerror("Error", f"Failed to read experiences: {err}")

    def delete_experience(self):
        try:
            user_id = int(self.exp_entries["User ID"].get())
            role = self.exp_entries["Role"].get()
            company = self.exp_entries["Company"].get()
            self.cursor.execute("DELETE FROM Experience WHERE UserID = %s AND Role = %s AND Company = %s", (user_id, role, company))
            self.conn.commit()
            messagebox.showinfo("Success", "Experience deleted.")
        except Exception as err:
            messagebox.showerror("Error", f"Failed to delete experience: {err}")

    def search_experience(self):
        try:
            query = "SELECT * FROM Experience WHERE 1=1"
            values = []
            mapping = {
                "User ID": "UserID",
                "Role": "Role",
                "Company": "Company",
                "Start Date (YYYY-MM-DD)": "StartDate",
                "End Date (YYYY-MM-DD)": "EndDate"
            }

            for label, column in mapping.items():
                val = self.exp_entries[label].get().strip()
                if val:
                    query += f" AND {column} LIKE %s"
                    values.append(f"%{val}%")

            self.cursor.execute(query, tuple(values))
            results = self.cursor.fetchall()
            self.exp_output.delete(1.0, tk.END)
            if not results:
                self.exp_output.insert(tk.END, "No experiences found.\n")
            else:
                for row in results:
                    self.exp_output.insert(tk.END, f"{row}\n")
        except Exception as err:
            messagebox.showerror("Error", f"Search failed: {err}")

if __name__ == "__main__":
    root = tk.Tk()
    app = LinkedInApp(root)
    root.mainloop()

